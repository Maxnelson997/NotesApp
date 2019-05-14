//
//  NoteDetailController.swift
//  NotesiOSApp
//
//  Created by Max Nelson on 3/22/19.
//  Copyright © 2019 Maxcodes. All rights reserved.
//

import UIKit

protocol NoteDelegate {
    func saveNewNote(title: String, date: Date, text: String)
}

class NoteDetailController: UIViewController {
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy 'at' h:mm a"
        return dateFormatter
    }()
    
    var noteData:Note! {
        didSet {
            textView.text = noteData.title
            dateLabel.text = dateFormatter.string(from: noteData.date ?? Date())
        }
    }
    
    var delegate: NoteDelegate?
    
    fileprivate var textView: UITextView = {
        let tf = UITextView()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = ""
        tf.isEditable = true
        tf.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return tf
    }()
    
    fileprivate lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        label.text = dateFormatter.string(from: Date())
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.noteData == nil {
            delegate?.saveNewNote(title: textView.text, date: Date(), text: textView.text)
        } else {
            // update our note here.
            guard let newText = self.textView.text else { return }
            CoreDataManager.shared.saveUpdatedNote(note: self.noteData, newText: newText)
        }
    }
    
    fileprivate func setupUI() {
        view.addSubview(dateLabel)
        view.addSubview(textView)
        
        dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        textView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let items: [UIBarButtonItem] = [
            UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .compose, target: nil, action: nil),
        ]
        
        self.toolbarItems = items
        
        let topItems:[UIBarButtonItem] = [
           UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil),
           UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        ]
        
        self.navigationItem.setRightBarButtonItems(topItems, animated: false)
    }
}

//
//  NoteCell.swift
//  NotesiOSApp
//
//  Created by Max Nelson on 3/22/19.
//  Copyright © 2019 Maxcodes. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    
    var noteData:Note! {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy"
            noteTitle.text = noteData.title
            dateLabel.text = dateFormatter.string(from: noteData.date ?? Date())
            previewLabel.text = noteData.text
        }
    }
    
    fileprivate var noteTitle: UILabel = {
        let label = UILabel()
        label.text = "Places to take photos"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    fileprivate var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "9/15/97"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    fileprivate var previewLabel: UILabel = {
        let label = UILabel()
        label.text = "the note text will go here to create a preview...."
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = UIColor.gray.withAlphaComponent(0.8)
        return label
    }()
    
    fileprivate lazy var horizontalStackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [dateLabel, previewLabel, UIView()])
        s.axis = .horizontal
        s.spacing = 10
        s.alignment = .leading
        return s
    }()
    
    fileprivate lazy var verticalStackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [noteTitle, horizontalStackView])
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.spacing = 4
        return s
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(verticalStackView)
        verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        verticalStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



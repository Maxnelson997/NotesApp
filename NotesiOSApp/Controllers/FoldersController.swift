//
//  ViewController.swift
//  NotesiOSApp
//
//  Created by Max Nelson on 3/19/19.
//  Copyright © 2019 Maxcodes. All rights reserved.
//

import UIKit


let firstFolderNotes = [
    Note(title: "UITableViews", date: Date(), text: "table views use protocols to recieve data."),
    Note(title: "Collection Views", date: Date(), text: "collection views can be customized with flow layouts to create layouts like you see in the Pinterest app.."),
    Note(title: "Flow Layouts", date: Date(), text: "custom layouts can be made with UICollectionViewFlowLayout")
]

let secondFolderNotes = [
    Note(title: "Instagram", date: Date(), text: "I have two Instagram accounts. maxcodes && maxcodes.io"),
    Note(title: "YouTube Channels", date: Date(), text: "I also have two youtube channels. One for iOS development videos, another for developer vlogs.")
]

var noteFolders:[NoteFolder] = [
    NoteFolder(title: "Course Notes", notes: firstFolderNotes),
    NoteFolder(title: "Social Media", notes: secondFolderNotes)
]


class FoldersController: UITableViewController {
    
    fileprivate let CELL_ID:String = "CELL_ID"
    
    fileprivate let headerView:UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        let label = UILabel(frame: CGRect(x: 20, y: 15, width: 100, height: 20))
        label.text = "ICLOUD"
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = .darkGray
        headerView.addBorder(toSide: .bottom, withColor: UIColor.lightGray.withAlphaComponent(0.5).cgColor, andThickness: 0.3)
        headerView.addSubview(label)
        return headerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Folders"
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        let items:[UIBarButtonItem] = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "New Folder", style: .done, target: self, action: #selector(self.handleAddNewFolder))
        ]
        
        self.toolbarItems = items
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)
        self.navigationItem.setRightBarButton(editButton, animated: false)
        self.navigationController?.toolbar.tintColor = .primaryColor
        self.navigationController?.navigationBar.tintColor = .primaryColor
        
        setupTranslucentViews()
    }
    
    var textField:UITextField!
    
    @objc fileprivate func handleAddNewFolder() {
        let addAlert = UIAlertController(title: "New Folder", message: "Enter a name for this folder.", preferredStyle: .alert)
        
        addAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            addAlert.dismiss(animated: true)
        }))

        addAlert.addTextField { (tf) in
            self.textField = tf
        }
        
        addAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            addAlert.dismiss(animated: true)
            guard let title = self.textField.text else { return }
            
            let newFolder = NoteFolder(title: title, notes: [])
            noteFolders.append(newFolder)
            self.tableView.insertRows(at: [IndexPath(row: noteFolders.count - 1, section: 0)], with: .fade)
        }))
        
        present(addAlert, animated: true)
    }

    fileprivate func setupTableView() {
        tableView.register(FolderCell.self, forCellReuseIdentifier: CELL_ID)
        tableView.tableHeaderView = headerView
    }
    
    fileprivate func getImage(withColor color: UIColor, andSize size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }
    
    fileprivate func setupTranslucentViews() {
        let toolBar = self.navigationController?.toolbar
        let navigationBar = self.navigationController?.navigationBar
        
        let slightWhite = getImage(withColor: UIColor.white.withAlphaComponent(0.9), andSize: CGSize(width: 30, height: 30))
        
        toolBar?.setBackgroundImage(slightWhite, forToolbarPosition: .any, barMetrics: .default)
        toolBar?.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        navigationBar?.setBackgroundImage(slightWhite, for: .default)
        navigationBar?.shadowImage = slightWhite
    }

}

extension FoldersController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteFolders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! FolderCell
        let folderForRow = noteFolders[indexPath.row]
        cell.folderData = folderForRow
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folderNotesController = FolderNotesController()
        let folderForRowSelected = noteFolders[indexPath.row]
        folderNotesController.folderData = folderForRowSelected
        navigationController?.pushViewController(folderNotesController, animated: true)
    }
    
}

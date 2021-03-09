//
//  ViewController.swift
//  Notes
//
//  Created by Helder on 28/08/20.
//  Copyright © 2020 Helder de Melo Sérvio Filho. All rights reserved.
//

import UIKit

class FoldersViewController: UITableViewController {
    
    var newFolderAlert: UIAlertController?
    var renameFolderAlert: UIAlertController?
    var folderIds: [Int] = [] {
        didSet {
            saveIds()
        }
    }
    var folderNames: [String] = [] {
        didSet {
            saveNames()
        }
    }
    var editingMode = false {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let bgImage = UIImage(named: "background.png") {
            view.backgroundColor = UIColor(patternImage: bgImage)
            navigationController?.toolbar.barTintColor = UIColor(patternImage: bgImage)
        }
        navigationController?.setToolbarHidden(false, animated: false)
        navigationController?.toolbar.layer.borderWidth = 0
        setToolbarItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(addNewFolder))], animated: false)
        toolbarItems?.forEach{$0.tintColor = UIColor(red: 0.88, green: 0.67, blue: 0, alpha: 1) }
        
        navigationItem.title = "Folders"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor(red: 0.88, green: 0.67, blue: 0, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(edit))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0.88, green: 0.67, blue: 0, alpha: 1)
        
        tableView.tableFooterView = UIView()
        
        let ud = UserDefaults()
        folderNames = ud.stringArray(forKey: "folders") ?? []
        if let folderIds = ud.array(forKey: "folderIds") as? [Int] {
            self.folderIds = folderIds
        } else {
            self.folderIds = []
        }
    }
    
    @objc func edit() {
        editingMode = !editingMode
        if editingMode {
            navigationItem.rightBarButtonItem?.title = "Done"
            navigationItem.rightBarButtonItem?.style = .done
        } else {
            navigationItem.rightBarButtonItem?.title = "Edit"
            navigationItem.rightBarButtonItem?.style = .plain
        }
    }
    
    @objc func addNewFolder() {
        newFolderAlert = UIAlertController(title: "New Folder", message: "Enter a name for this folder.", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [weak self] action in
            if let text = self?.newFolderAlert?.textFields?.first?.text {
                self?.folderNames.append(text)
                self?.folderIds.append(UUID().hashValue)
                if let count = self?.folderNames.count {
                    self?.tableView.insertRows(at: [IndexPath(row: count - 1, section: 0)], with: .automatic)
                }
            }
        }
        newFolderAlert?.addTextField { (textField) in
            textField.placeholder = "Name"
            textField.tintColor = UIColor(red: 0.88, green: 0.67, blue: 0, alpha: 1)
            textField.addTarget(self, action: #selector(self.enableDisableNewFolderSave(_:)), for: .editingChanged)
            textField.becomeFirstResponder()
        }
        
        newFolderAlert?.addAction(UIAlertAction(title: "Cancel", style: .default))
        newFolderAlert?.addAction(saveAction)
        saveAction.isEnabled = false
        newFolderAlert?.actions.forEach{$0.setValue(UIColor(red: 0.88, green: 0.67, blue: 0, alpha: 1), forKey: "titleTextColor")}
        if let ac = newFolderAlert {
            present(ac, animated: true)
        }
        
    }
    
    @objc func renameFolder(of index: Int) {
        renameFolderAlert = UIAlertController(title: "Rename Folder", message: nil, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [weak self] action in
            if let text = self?.renameFolderAlert?.textFields?.first?.text {
                self?.folderNames[index] = text
                self?.tableView.reloadData()
            }
        }
        renameFolderAlert?.addTextField { (textField) in
            textField.placeholder = "Name"
            textField.text = self.folderNames[index]
            textField.tintColor = UIColor(red: 0.88, green: 0.67, blue: 0, alpha: 1)
            textField.addTarget(self, action: #selector(self.enableDisableRenameFolderSave(_:)), for: .editingChanged)
        }
        
        renameFolderAlert?.addAction(UIAlertAction(title: "Cancel", style: .default))
        renameFolderAlert?.addAction(saveAction)
        saveAction.isEnabled = false
        renameFolderAlert?.actions.forEach{$0.setValue(UIColor(red: 0.88, green: 0.67, blue: 0, alpha: 1), forKey: "titleTextColor")}
        if let ac = renameFolderAlert {
            present(ac, animated: true)
        }
        
    }
    
    @objc func deleteFolder(of index: Int) {
        folderNames.remove(at: index)
        folderIds.remove(at: index)
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    @objc func enableDisableNewFolderSave(_ sender: UITextField) {
        guard let count = sender.text?.count else { return }
        newFolderAlert?.actions[1].isEnabled = count > 0
    }
    
    @objc func enableDisableRenameFolderSave(_ sender: UITextField) {
        guard let count = sender.text?.count else { return }
        renameFolderAlert?.actions[1].isEnabled = count > 0
    }
    
    @objc func openFolderOptionsMenu(sender: UIButton) {
        if let folderMenuNVC = storyboard?.instantiateViewController(withIdentifier: "folderMenuNavigationController") as? UINavigationController {
            folderMenuNVC.modalPresentationStyle = .formSheet
            folderMenuNVC.preferredContentSize = CGSize(width: 100, height: 100)
            if let folderMenuVC = folderMenuNVC.topViewController as? FolderMenuViewController {
                folderMenuVC.folderName = folderNames[sender.tag]
                folderMenuVC.index = sender.tag
                folderMenuVC.addFolder = addNewFolder
                folderMenuVC.renameFolder = renameFolder(of:)
                folderMenuVC.deleteFolder = deleteFolder(of:)
            }
            present(folderMenuNVC, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderNames.count
    }
    
    func addEditButton(to cell: UITableViewCell, of index: Int) -> UIButton {
        let cellEditButton = UIButton(frame: CGRect.zero)
        cellEditButton.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(cellEditButton)
        cell.accessoryView = cellEditButton
        cellEditButton.tag = index
        cellEditButton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        cellEditButton.addTarget(self, action: #selector(openFolderOptionsMenu), for: .touchUpInside)
        cellEditButton.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        cellEditButton.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -10).isActive = true
        cellEditButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return cellEditButton
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderCell", for: indexPath)
        cell.textLabel?.text = folderNames[indexPath.row]
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        let cellEditButton = addEditButton(to: cell, of: indexPath.row)
        if editingMode {
            cellEditButton.isHidden = false
        } else {
            cellEditButton.isHidden = true
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            folderNames.remove(at: indexPath.row)
            folderIds.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !editingMode {
            guard let nvc = storyboard?.instantiateViewController(withIdentifier: "Notes") as? NotesViewController else { return }
            nvc.folderName = folderNames[indexPath.row]
            nvc.folderId = folderIds[indexPath.row]
            navigationController?.pushViewController(nvc, animated: true)
        }
    }
    
    func saveNames() {
        let ud = UserDefaults()
        ud.set(folderNames, forKey: "folders")
    }
    
    func saveIds() {
        let ud = UserDefaults()
        ud.set(folderIds, forKey: "folderIds")
    }

}


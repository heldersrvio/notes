//
//  FolderMenuViewController.swift
//  Notes
//
//  Created by Helder on 02/23/2021.
//  Copyright © 2021 Helder de Melo Sérvio Filho. All rights reserved.
//

import UIKit

class FolderMenuViewController: UITableViewController, UINavigationBarDelegate {
    var folderName: String!
    var index: Int!
    var addFolder: (() -> Void)!
    var renameFolder: ((Int) -> Void)!
    var deleteFolder: ((Int) -> Void)!
    let options = ["Add Folder", "Rename", "Delete"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = folderName
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderMenuCell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true)
        switch indexPath.row {
        case 0:
            addFolder()
        case 1:
            renameFolder(index)
        default:
            deleteFolder(index)
        }
    }
}

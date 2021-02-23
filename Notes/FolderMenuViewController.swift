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
    let options = ["Share Folder", "Add Folder", "Move This Folder", "Rename", "Delete"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = folderName
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderMenuCell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }

}

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
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.close, target: self, action: #selector(close))
        navigationItem.rightBarButtonItem = button
        let navigationView = UIView()
        let label = UILabel()
        label.text = folderName
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.sizeToFit()
        label.center = CGPoint(x: navigationView.center.x - label.frame.size.height * 3, y: navigationView.center.y)
        let folderIcon = UIImageView()
        folderIcon.image = UIImage(systemName: "folder.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .regular, scale: .large))?.withTintColor(UIColor(red: 0.88, green: 0.67, blue: 0, alpha: 1), renderingMode: .alwaysOriginal)
        let imageAspect = folderIcon.image!.size.width / folderIcon.image!.size.height
        folderIcon.frame = CGRect(x: label.frame.origin.x - label.frame.size.height * imageAspect * 1.7, y: label.frame.origin.y - label.frame.size.height * 0.25, width: label.frame.size.height * 1.5 * imageAspect, height: label.frame.size.height * 1.5)
        folderIcon.contentMode = UIView.ContentMode.scaleAspectFit
        navigationView.addSubview(label)
        navigationView.addSubview(folderIcon)
        navigationItem.titleView = navigationView
        navigationView.sizeToFit()
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
    
    @objc func close() {
        dismiss(animated: true)
    }
}

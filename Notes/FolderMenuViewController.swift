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
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.backgroundColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1)
        let cellsBackground = UIView()
        cellsBackground.backgroundColor = UIColor.white
        cellsBackground.frame = CGRect(x: tableView.frame.minX + tableView.frame.width * 0.045, y: tableView.frame.minY + 15, width: tableView.frame.width / 1.1, height: tableView.frame.height / 7)
        cellsBackground.layer.zPosition = -1
        tableView.addSubview(cellsBackground)
        
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
        folderIcon.frame = CGRect(x: label.frame.origin.x - label.frame.size.height * 2.64, y: label.frame.origin.y - label.frame.size.height * 0.25, width: label.frame.size.height * 1.5 * imageAspect, height: label.frame.size.height * 1.5)
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
        if let cell = cell as? FolderMenuViewCell {
            cell.textLabel?.text = options[indexPath.row]
            let iconImageView = UIImageView()
            iconImageView.tintColor = UIColor.black
            iconImageView.image = indexPath.row == 0 ? UIImage(systemName: "folder.badge.plus") : indexPath.row == 1 ? UIImage(systemName: "pencil") : UIImage(systemName: "trash")
            if let size = iconImageView.image?.size {
                print(cell.contentView.frame.width)
                iconImageView.frame = CGRect(x: cell.contentView.frame.minX + 270 - cell.contentView.frame.width / 22, y: cell.contentView.frame.midY - size.height / 2, width: size.width, height: size.height)
            }
            cell.contentView.addSubview(iconImageView)
            return cell
        }
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

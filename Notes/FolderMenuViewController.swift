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
        /*cellsBackground.translatesAutoresizingMaskIntoConstraints = false
        let cellsBackGroundWidthConstraint = NSLayoutConstraint(item: cellsBackground, attribute: .width, relatedBy: .equal, toItem: tableView, attribute: .width, multiplier: 1.2, constant: 0)
        let cellsBackGroundTopConstraint = NSLayoutConstraint(item: cellsBackground, attribute: .top, relatedBy: .equal, toItem: tableView, attribute: .top, multiplier: 1, constant: 15)
        let cellsBackGroundBottomConstraint = NSLayoutConstraint(item: cellsBackground, attribute: .bottom, relatedBy: .equal, toItem: tableView, attribute: .bottom, multiplier: 1, constant: -15)
        tableView.addConstraints([cellsBackGroundWidthConstraint, cellsBackGroundTopConstraint, cellsBackGroundBottomConstraint])*/
        
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
        navigationView.addSubview(label)
        navigationView.addSubview(folderIcon)
        label.translatesAutoresizingMaskIntoConstraints = false
        folderIcon.translatesAutoresizingMaskIntoConstraints = false
        let labelLeadingConstraint = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: navigationView, attribute: .leading, multiplier: 1, constant: 30)
        let labelVerticalConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: navigationView, attribute: .centerY, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: folderIcon, attribute: .centerY, relatedBy: .equal, toItem: navigationView, attribute: .centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: folderIcon, attribute: .width, relatedBy: .equal, toItem: navigationView, attribute: .width, multiplier: 0, constant: label.frame.size.height * 1.5 * imageAspect)
        let heightConstraint = NSLayoutConstraint(item: folderIcon, attribute: .height, relatedBy: .equal, toItem: navigationView, attribute: .height, multiplier: 0, constant: label.frame.size.height * 1.5)
        let trailingConstraint = NSLayoutConstraint(item: folderIcon, attribute: .trailing, relatedBy: .equal, toItem: label, attribute: .leading, multiplier: 1, constant: -15)
        navigationView.addConstraints([verticalConstraint, widthConstraint, heightConstraint, trailingConstraint, labelLeadingConstraint, labelVerticalConstraint])
        
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
            cell.contentView.addSubview(iconImageView)
            if let size = iconImageView.image?.size {
                iconImageView.translatesAutoresizingMaskIntoConstraints = false
                let verticalConstraint = NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: cell.contentView, attribute: .centerY, multiplier: 1, constant: 0)
                let trailingConstraint = NSLayoutConstraint(item: iconImageView, attribute: .trailing, relatedBy: .equal, toItem: cell.contentView, attribute: .trailing, multiplier: 1, constant: -20)
                let widthConstraint = NSLayoutConstraint(item: iconImageView, attribute: .width, relatedBy: .equal, toItem: cell.contentView, attribute: .width, multiplier: 0, constant: size.width)
                cell.contentView.addConstraints([verticalConstraint, trailingConstraint, widthConstraint])
            }
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

//
//  FolderMenuViewCell.swift
//  Notes
//
//  Created by Helder on 03/07/2021.
//  Copyright © 2021 Helder de Melo Sérvio Filho. All rights reserved.
//

import UIKit

class FolderMenuViewCell: UITableViewCell {
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            super.frame = CGRect(x: newFrame.minX + newFrame.width / 22, y: newFrame.minY, width: newFrame.width / 1.1, height: newFrame.height)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

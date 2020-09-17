//
//  RenameViewController.swift
//  Notes
//
//  Created by Helder on 13/09/20.
//  Copyright © 2020 Helder de Melo Sérvio Filho. All rights reserved.
//

import UIKit

class RenameViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField! {
        didSet {
            if name != nil {
                nameField.text = name
            }
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        deleteFolder()
        dismissView()
    }
    var name: String! {
        didSet {
            if nameField != nil {
                nameField.text = name
            }
        }
    }
    var saveName: ((String) -> Void)!
    var deleteFolder: (() -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        nameField.layer.borderWidth = 1.0
        nameField.layer.borderColor = UIColor.lightGray.cgColor
        navigationItem.title = "Rename"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0.88, green: 0.67, blue: 0, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 0.88, green: 0.67, blue: 0, alpha: 1)
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
    
    @objc func save() {
        saveName(nameField.text ?? "")
        dismissView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

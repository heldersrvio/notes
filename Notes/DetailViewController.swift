//
//  DetailViewController.swift
//  Notes
//
//  Created by Helder on 28/08/20.
//  Copyright © 2020 Helder de Melo Sérvio Filho. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textView: UITextView!
    var noteId: String = UUID().uuidString
    var addNoteToTableView: ((String, String) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 35)
        textView.delegate = self

        if let bgImage = UIImage(named: "background.png") {
            view.backgroundColor = UIColor(patternImage: bgImage)
            navigationController?.toolbar.barTintColor = UIColor(patternImage: bgImage)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let ud = UserDefaults()
        if !textView.text.isEmpty {
            ud.set(textView.text, forKey: noteId)
            let components = textView.text.components(separatedBy: "\n").filter{$0 != "\n"}
            if let title = components.first {
                let subtitle = components[1...components.count - 1].joined(separator: " ")
                addNoteToTableView(title, subtitle)
            }
        } else {
            ud.removeObject(forKey: noteId)
        }
    }
}

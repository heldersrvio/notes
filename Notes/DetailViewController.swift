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
    var noteId: String!
    var addNoteToTableView: (() -> Void)!
    var removeNoteFromTableView: (() -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let text = UserDefaults().string(forKey: "\(noteId!)Note") {
            textView.text = text
        }
        textView.delegate = self

        if let bgImage = UIImage(named: "background.png") {
            view.backgroundColor = UIColor(patternImage: bgImage)
            navigationController?.toolbar.barTintColor = UIColor(patternImage: bgImage)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let ud = UserDefaults()
        if let _ = ud.string(forKey: "\(noteId!)Note") {
            if !textView.text.isEmpty {
                ud.set(textView.text, forKey: "\(noteId!)Note")
            } else {
                ud.removeObject(forKey: "\(noteId!)Note")
                removeNoteFromTableView()
            }
        } else {
            if !textView.text.isEmpty {
                ud.set(textView.text, forKey: "\(noteId!)Note")
                addNoteToTableView()
            }
        }
    }
}

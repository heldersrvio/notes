//
//  NotesViewController.swift
//  Notes
//
//  Created by Helder on 28/08/20.
//  Copyright © 2020 Helder de Melo Sérvio Filho. All rights reserved.
//

import UIKit

class NotesViewController: UITableViewController {
    
    var folderId: Int!
    var folderName: String!
    var noteIds: [String] = [] {
        didSet {
            saveIds()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = folderName
        
        if let bgImage = UIImage(named: "background.png") {
            view.backgroundColor = UIColor(patternImage: bgImage)
            navigationController?.toolbar.barTintColor = UIColor(patternImage: bgImage)
        }
        
        let ud = UserDefaults()
        
        if let folderId = folderId {
            noteIds = ud.stringArray(forKey: "\(folderId)NoteIds") ?? []
        }
        
        navigationController?.setToolbarHidden(false, animated: false)
        navigationController?.toolbar.layer.borderWidth = 0
        setToolbarItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(newNote))], animated: false)
        toolbarItems?.forEach{$0.tintColor = UIColor(red: 0.88, green: 0.67, blue: 0, alpha: 1) }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return noteIds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath)
        let ud = UserDefaults()
        if let noteText = ud.string(forKey: "\(noteIds[indexPath.row])Note") {
            let noteTextComponents = noteText.components(separatedBy: "\n")
            if let noteTitle = noteTextComponents.first {
                cell.textLabel?.text = noteTitle
            }
            if noteTextComponents.count > 1 {
                cell.detailTextLabel?.text = noteTextComponents[1...noteTextComponents.count - 1].joined(separator: "\n")
            } else {
                cell.detailTextLabel?.text = ""
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return }
        dvc.noteId = noteIds[indexPath.row]
        dvc.addNoteToTableView = {
            [weak self] in
            self?.noteIds.append(dvc.noteId)
            if let count = self?.noteIds.count {
                self?.tableView.insertRows(at: [IndexPath(row: count - 1, section: 0)], with: .automatic)
            }
        }
        dvc.removeNoteFromTableView = {
            [weak self] in
            self?.noteIds.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        navigationController?.pushViewController(dvc, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            noteIds.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func newNote() {
        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return }
        dvc.noteId = UUID().uuidString
        dvc.addNoteToTableView = {
            [weak self] in
            self?.noteIds.append(dvc.noteId)
            if let count = self?.noteIds.count {
                self?.tableView.insertRows(at: [IndexPath(row: count - 1, section: 0)], with: .automatic)
            }
        }
        dvc.removeNoteFromTableView = {
            [weak self] in
            if let count = self?.noteIds.count {
                self?.noteIds.remove(at: count - 1)
                self?.tableView.deleteRows(at: [IndexPath(row: count - 1, section: 1)], with: .automatic)
            }
        }
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    func saveIds() {
        let ud = UserDefaults()
        ud.set(noteIds, forKey: "\(folderId!)NoteIds")
    }
    
}

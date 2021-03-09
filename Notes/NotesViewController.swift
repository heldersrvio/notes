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
    var noteTitles: [String] = [] {
        didSet {
            saveTitles()
        }
    }
    var noteSubtitles: [String] = [] {
        didSet {
            saveSubtitles()
        }
    }
    var noteIds: [String] = [] {
        didSet {
            saveIds()
        }
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
            noteTitles = ud.stringArray(forKey: "\(folderId)Titles") ?? []
            noteSubtitles = ud.stringArray(forKey: "\(folderId)Subtitles") ?? []
            noteIds = ud.stringArray(forKey: "\(folderId)NoteIds") ?? []
        }
        
        navigationController?.setToolbarHidden(false, animated: false)
        navigationController?.toolbar.layer.borderWidth = 0
        setToolbarItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(newNote))], animated: false)
        toolbarItems?.forEach{$0.tintColor = UIColor(red: 0.88, green: 0.67, blue: 0, alpha: 1) }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return noteTitles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath)
        cell.textLabel?.text = noteTitles[indexPath.row]
        cell.detailTextLabel?.text = noteSubtitles[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return }
        dvc.addNoteToTableView = {
            [weak self] (title, subtitle) in
            let id = UUID().uuidString
            self?.noteSubtitles.append(subtitle)
            self?.noteTitles.append(title)
            self?.noteIds.append(id)
            if let count = self?.noteSubtitles.count {
                self?.tableView.insertRows(at: [IndexPath(row: count - 1, section: 0)], with: .automatic)
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            noteTitles.remove(at: indexPath.row)
            noteSubtitles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func newNote() {
        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return }
        dvc.addNoteToTableView = {
            [weak self] (title, subtitle) in
            let id = UUID().uuidString
            self?.noteSubtitles.append(subtitle)
            self?.noteTitles.append(title)
            self?.noteIds.append(id)
            if let count = self?.noteSubtitles.count {
                self?.tableView.insertRows(at: [IndexPath(row: count - 1, section: 0)], with: .automatic)
            }
        }
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    func saveTitles() {
        let ud = UserDefaults()
        ud.set(noteTitles, forKey: "\(folderId!)Titles")
    }
    
    func saveSubtitles() {
        let ud = UserDefaults()
        ud.set(noteSubtitles, forKey: "\(folderId!)Subtitles")
    }
    
    func saveIds() {
        let ud = UserDefaults()
        ud.set(noteIds, forKey: "\(folderId!)NoteIds")
    }
    
}

//
//  ViewController.swift
//  Note-App
//
//  Created by Abdirizak Hassan on 11/30/21.
//

import UIKit

protocol DataDelegate {
    func updateNotes(newNotes: String)
}

class NoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum segue {
        static let main = "Segue.Main.show"
    }
    
    @IBOutlet var tableView: UITableView!
    
    var notes: [Notes] = []
    var selectedNotes: Notes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Note"
        tableView.dataSource = self
        tableView.delegate   = self
        NetworkManager.shared.delegate = self
        NetworkManager.shared.fetNotes()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath) as! NoteTableViewCell
        cell.textLabel?.text = notes[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNotes = notes[indexPath.row]
        performSegue(withIdentifier: segue.main, sender: selectedNotes)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let noteDetail = segue.destination as? AddNoteViewController, let sender = sender as? Notes {
            noteDetail.NoteDetails = sender
        }
    }
}

extension NoteViewController: DataDelegate {
    
    
    func updateNotes(newNotes: String) {
        do{
            let result = try JSONDecoder().decode([Notes].self, from: newNotes.data(using: .utf8)!)
            self.notes = result
            print(result)
            
        } catch {
            print(error)
        }
        self.tableView.reloadData()
    }
    
}


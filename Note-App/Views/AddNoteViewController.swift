//
//  AddNoteViewController.swift
//  Note-App
//
//  Created by Abdirizak Hassan on 11/30/21.
//

import UIKit

class AddNoteViewController: UIViewController {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var bodyTextView: UITextView!
    
    var NoteDetails: Notes?
    var update: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if update{
            let sharebtn = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), landscapeImagePhone: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareTapped))
            let deleteBtn = UIBarButtonItem(image: UIImage(systemName: "trash"), landscapeImagePhone: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteTapped))
            let savebtn = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(saveTapped))
            navigationItem.rightBarButtonItems = [savebtn, sharebtn, deleteBtn]
        }
        guard let noteDetails = NoteDetails else {
            return
        }
        if update {
            titleTextField.text = noteDetails.title
            bodyTextView.text = noteDetails.note
        }
        
    }
    
    @objc func shareTapped() {
        guard let Notetxt = NoteDetails else {
            print("No Note")
            return
        }
        let activity = UIActivityViewController(activityItems: [Notetxt.title + "\n" + Notetxt.note], applicationActivities: [])
        activity.popoverPresentationController?.sourceView = self.view
        present(activity, animated: true, completion: nil)
    }
    
    
    func show(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func deleteTapped(){
        NetworkManager.shared.deleteNote(noteID: NoteDetails!.id)
        navigationController?.popViewController(animated: true)
    }

    @IBAction func saveTapped(_ sender: Any){
        let title = titleTextField.text
        let body  = bodyTextView.text
        if (title?.isEmpty)! || (body?.isEmpty)! {
            print("title and body cannot be empty")
            return
        }
        let parameters: [String: String] = ["title": titleTextField.text!,
                                            "note": bodyTextView.text!,
                                            "date":"\(Date.now.ISO8601Format())"]
        if update == true {
            guard let notID = NoteDetails else { return }
//            print(notID)
            NetworkManager.shared.updateNote(parameters: parameters, noteID: notID.id)
        } else {
            NetworkManager.shared.addNotes(parameters: parameters)
        }
        navigationController?.popViewController(animated: true)
    }
}


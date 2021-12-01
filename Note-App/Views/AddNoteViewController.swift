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
        guard let noteDetails = NoteDetails else {
            return
        }
        if update == true {
            titleTextField.text = noteDetails.title
            bodyTextView.text = noteDetails.note
        }
        
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
            print(notID)
            NetworkManager.shared.updateNote(parameters: parameters, noteID: notID.id)
        } else {
            NetworkManager.shared.addNotes(parameters: parameters)
        }
        navigationController?.popViewController(animated: true)
    }
}

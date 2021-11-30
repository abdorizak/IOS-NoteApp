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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let deleteBtn = UIBarButtonItem(title: "delete", style: .plain, target: self, action: nil)
        let saveBtn = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(saveNote))
        navigationItem.rightBarButtonItems = [saveBtn, deleteBtn]
    }
    
    
    @objc func saveNote() {
        let title = titleTextField.text
        let body = bodyTextView.text
        if (title?.isEmpty)! || (body?.isEmpty)! {
            print("title and body cannot be empty")
            return
        }
        
        let parameters: [String: String] = ["title": titleTextField.text!,
                          "note": bodyTextView.text!,
                                            "date":"\(Date.now.ISO8601Format())"
        ]
        NetworkManager.shared.addNotes(parameters: parameters)
    }

}

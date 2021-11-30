//
//  ViewController.swift
//  Note-App
//
//  Created by Abdirizak Hassan on 11/30/21.
//

import UIKit

class NoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Note"
        tableView.dataSource = self
        tableView.delegate   = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath) as! NoteTableViewCell
        cell.textLabel?.text = "Note"
        
        return cell
    }
    
    
}


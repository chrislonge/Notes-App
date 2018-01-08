//
//  MasterViewController.swift
//  Notes-App
//
//  Created by Longe, Chris on 1/5/18.
//  Copyright © 2018 Capital One. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    let cellIdentifier = "noteCell"
    let showNoteSegue = "showNote"
    let showNewNoteSegue = "showNewNote"
    
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        notes.append(Note(content: "Hello"))
        notes.append(Note(content: "World!"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = notes[indexPath.row].content

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == showNoteSegue {
            if let indexPath = tableView.indexPathForSelectedRow {
                let note = notes[indexPath.row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.delegate = self
                detailViewController.note = note
                detailViewController.noteIndex = indexPath.row
            }
        } else if segue.identifier == showNewNoteSegue {
            // Insert a new Note to the model before transitioning to DetailViewController
            notes.insert(Note(content: "New note"), at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            // Insert a new row in our tableView
            tableView.insertRows(at: [indexPath], with: .automatic)
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.delegate = self
            detailViewController.note = notes[0]
            detailViewController.noteIndex = 0
        }
    }
}

extension MasterViewController: NoteUpdateDelegate {
    func updateNote(_ note: Note, at index: Int) {
        notes[index] = note
        tableView.reloadData()
    }
}

//
//  ViewController.swift
//  Notes-App
//
//  Created by Longe, Chris on 1/5/18.
//  Copyright © 2018 Capital One. All rights reserved.
//

import UIKit

protocol NoteUpdateDelegate: class {
    func updateNote(_ note: Note, at index: Int)
}

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var note: Note?
    var noteIndex: Int?
    
    weak var delegate: NoteUpdateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Update the current note
        note?.content = textView.text
        // Unwrap both optionals, then use the delegate to call function
        if let note = note, let index = noteIndex {
            delegate?.updateNote(note, at: index)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureView() {
        if let note = note {
            textView.text = note.content
        }
    }
}

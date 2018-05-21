//
//  Note.swift
//  Notes-App
//
//  Created by Chris Longe on 1/7/18.
//  Copyright © 2018 Capital One. All rights reserved.
//

import Foundation

class Note {
    var content: String?
    let dateCreated = Date()
    
    init(withContent content: String) {
        self.content = content
    }
}

//: [Previous](@previous)

// Import Foundation to use Date.
// Swift offers Int/UInt, Float, Double, Bool, String, Character, Optional, and Tuples.
import Foundation

// Create model with optional

// To define a class use the 'class' keyword

protocol Note {
    var content: String? { get set }
    var dateCreated: Date { get set }
    //func printContent()
}

class NoteClass: Note {
    var content: String?
    var dateCreated: Date
    
    init(content: String, dateCreated: Date) {
        self.content = content
        self.dateCreated = dateCreated
    }
    
    init(content: String) {
        self.content = content
        self.dateCreated = Date()
    }
}

struct NoteStruct {
    var content: String?
    var dateCreated = Date()
    
    init(content: String, dateCreated: Date) {
        self.content = content
        self.dateCreated = dateCreated
    }
}

// Class is pass by reference
var firstNoteClass = NoteClass(content: "The first notes content", dateCreated: Date())
var secondNoteClass = firstNoteClass
secondNoteClass.content = "The second notes content"
print(firstNoteClass.content!)

// Struct is pass by value (copies)
var firstNoteStruct = NoteStruct(content: "The first notes content", dateCreated: Date())
var secondNoteStruct = firstNoteStruct
secondNoteStruct.content = "The second notes content"
//print(firstNoteStruct.content!)

// Using powerful swift protocols

//: [Next](@next)

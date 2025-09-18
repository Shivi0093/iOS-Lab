//
//  ToDo.swift
//  ToDoList
//
//  Created by Student on 16/9/2025.
//

import Foundation

struct ToDo: Equatable, Codable {
    let id: UUID // Unique identifier for the ToDo item
    var title: String // Title of the ToDo
    var isComplete: Bool // Flag indicating completion status
    var dueDate: Date // Due date of the ToDo
    var notes: String? // Optional notes for the ToDo
    
    // Initializer for creating a ToDo instance
    init(title: String, isComplete: Bool, dueDate: Date, notes: String? = nil) {
        self.id = UUID() // Generate a new UUID for the ToDo
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
    }
    
    // URL for data storage and retrieval
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
  
    // Method to save ToDo items to persistent storage
    static func saveToDos(_ toDos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(toDos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
    
    // Method to load ToDo items from persistent storage
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: archiveURL) else
        { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    // Method to load sample ToDo items for initial display
    static func loadSampleToDos() -> [ToDo] {
        let toDo1 = ToDo(title: "Wash Clothing", isComplete: false, dueDate: Date(), notes: "This should be completed weekly")
        let toDo2 = ToDo(title: "Clean Kitchen", isComplete: false, dueDate: Date(), notes: "This should be done daily")
        let toDo3 = ToDo(title: "Wash Windows", isComplete: false, dueDate: Date(), notes: "This should be done quarterly")
        
        return [toDo1, toDo2, toDo3]
    }
    
    // Equatable conformance to compare ToDo items by their ID
    static func == (lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
}



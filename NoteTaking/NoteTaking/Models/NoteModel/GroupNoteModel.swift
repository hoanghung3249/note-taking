//
//  GroupNoteModel.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 26/03/2022.
//

import Foundation

enum GroupNoteType: String, Codable {
    case folder
    case list
    
    var imageIconName: String {
        switch self {
        case .folder: return "folder"
        case .list: return "file"
        }
    }
    
    var title: String {
        switch self {
        case .folder: return "Folder"
        case .list: return "List"
        }
    }
}

struct GroupNoteModel: Codable, Identifiable {
    var id = UUID()
    var name: String
    var numberOfNote: Int
    var dateAdded: Date
    var groupNoteType: GroupNoteType
    var notes = [NoteModel]()
}

let mockingGroupNotes = [
    GroupNoteModel(name: "Work", numberOfNote: 3, dateAdded: Date(), groupNoteType: .folder, notes: [
        NoteModel(title: "Notes about Flutter and Dart", noteDetail: "Testing", dateAdded: Date().previousDate().previousDate()),
        NoteModel(title: "SwiftUI and Combine", noteDetail: "Testing", dateAdded: Date().previousDate()),
        NoteModel(title: "Algorithm and Data Structure in Swift", noteDetail: "Testing", dateAdded: Date().previousDate().previousDate()),
    ]
    ),
    GroupNoteModel(name: "Resources", numberOfNote: 5, dateAdded: Date(), groupNoteType: .folder),
    GroupNoteModel(name: "Movies", numberOfNote: 16, dateAdded: Date(), groupNoteType: .folder),
    GroupNoteModel(name: "To Do List", numberOfNote: 6, dateAdded: Date(), groupNoteType: .list),
    GroupNoteModel(name: "Groceries", numberOfNote: 6, dateAdded: Date(), groupNoteType: .list),
    GroupNoteModel(name: "Quotes", numberOfNote: 10, dateAdded: Date(), groupNoteType: .list),
    GroupNoteModel(name: "Books", numberOfNote: 7, dateAdded: Date(), groupNoteType: .folder),
    GroupNoteModel(name: "Task", numberOfNote: 7, dateAdded: Date(), groupNoteType: .folder)
]



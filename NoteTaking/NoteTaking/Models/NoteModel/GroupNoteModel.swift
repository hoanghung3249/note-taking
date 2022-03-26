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
}

struct GroupNoteModel: Codable, Identifiable {
    var id = UUID()
    var name: String
    var numberOfNote: Int
    var dateAdded: Date
    var groupNoteType: GroupNoteType
    
}

let mockingGroupNotes = [
    GroupNoteModel(name: "Work", numberOfNote: 3, dateAdded: Date(), groupNoteType: .folder),
    GroupNoteModel(name: "Resources", numberOfNote: 5, dateAdded: Date(), groupNoteType: .folder),
    GroupNoteModel(name: "Movies", numberOfNote: 16, dateAdded: Date(), groupNoteType: .folder),
    GroupNoteModel(name: "To Do List", numberOfNote: 6, dateAdded: Date(), groupNoteType: .list),
    GroupNoteModel(name: "Groceries", numberOfNote: 6, dateAdded: Date(), groupNoteType: .list),
    GroupNoteModel(name: "Quotes", numberOfNote: 10, dateAdded: Date(), groupNoteType: .list),
    GroupNoteModel(name: "Books", numberOfNote: 7, dateAdded: Date(), groupNoteType: .folder),
    GroupNoteModel(name: "Task", numberOfNote: 7, dateAdded: Date(), groupNoteType: .folder)
]



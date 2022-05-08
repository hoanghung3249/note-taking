//
//  NoteModel.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 26/03/2022.
//

import Foundation

struct NoteModel: Codable, Identifiable {
    var id = UUID()
    var title: String = ""
    var noteDetail: String = ""
    var noteDetailAttributed: NSAttributedString!
    var dateAdded: Date?
    
    init(from decoder: Decoder) throws {
        let singleContainer = try decoder.singleValueContainer()
        guard let attributedString = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(singleContainer.decode(Data.self)) as? NSAttributedString else {
            throw DecodingError.dataCorruptedError(in: singleContainer, debugDescription: "Data is corrupted")
        }
        self.noteDetailAttributed = attributedString
    }
    
    func encode(to encoder: Encoder) throws {
        guard let noteDetailAttributed = noteDetailAttributed else {
            return
        }
        var singleContainer = encoder.singleValueContainer()
        try singleContainer.encode(NSKeyedArchiver.archivedData(withRootObject: noteDetailAttributed, requiringSecureCoding: false))
    }
    
    init(title: String, noteDetail: String, dateAdded: Date? = nil) {
        self.title = title
        self.noteDetail = noteDetail
        self.noteDetailAttributed = NSMutableAttributedString(string: noteDetail)
        self.dateAdded = dateAdded
    }
}

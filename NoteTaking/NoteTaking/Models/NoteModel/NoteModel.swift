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
    var dateAdded: Date?
}

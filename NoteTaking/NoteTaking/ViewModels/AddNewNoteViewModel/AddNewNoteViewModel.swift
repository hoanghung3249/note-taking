//
//  AddNewNoteViewModel.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 09/04/2022.
//

import Foundation

class AddNewNoteViewModel: ObservableObject {
    
    @Published var noteModel = NoteModel()
    
    init(noteModel: NoteModel?) {
        if let noteModel = noteModel {
            self.noteModel = noteModel
        }
    }
    
    
    func createNewNote() {
        noteModel.dateAdded = Date()
        print(noteModel)
    }
}

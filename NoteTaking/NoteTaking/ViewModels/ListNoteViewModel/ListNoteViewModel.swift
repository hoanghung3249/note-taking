//
//  ListNoteViewModel.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 10/04/2022.
//

import Foundation

class ListNoteViewModel: ObservableObject {
    
    @Published var listNotesModel: GroupNoteModel?
    
    init(groupNoteModel: GroupNoteModel) {
        self.listNotesModel = groupNoteModel
    }
    
}

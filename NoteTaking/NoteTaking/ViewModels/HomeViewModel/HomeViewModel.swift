//
//  HomeViewModel.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 26/03/2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var groupNotes = [GroupNoteModel]()
    @Published var isLoading = true
    
    func fetchGroupNote() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.groupNotes = mockingGroupNotes
            self.isLoading = false
        }
    }
}

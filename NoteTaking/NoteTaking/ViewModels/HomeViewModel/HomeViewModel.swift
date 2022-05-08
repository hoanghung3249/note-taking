//
//  HomeViewModel.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 26/03/2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published private(set) var groupNotes = [GroupNoteModel]()
    @Published private(set) var isLoading = true
    
    func fetchGroupNote() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.groupNotes = mockingGroupNotes
            self.isLoading = false
        }
    }
}

//
//  HomeViewModel.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 26/03/2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var groupNotes = mockingGroupNotes
    
}

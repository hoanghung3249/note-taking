//
//  Int+Extension.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 25/06/2022.
//

import Foundation

extension Int {
    
    func toNoteFormat() -> String {
        return self > 1 ? "notes" : "note"
    }
    
}

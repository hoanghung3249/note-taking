//
//  AddNewNoteViewModel.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 09/04/2022.
//

import Foundation
import UIKit
import SwiftUI
import Combine

enum AddNoteType {
    case emptyGroup
    case withGroup(groupModel: GroupNoteModel)
    case withAllGroup(groupsModel: [GroupNoteModel])
}

class AddNewNoteViewModel: ObservableObject {
    
    @Published var noteModel = NoteModel(title: "", noteDetail: "", dateAdded: nil)
    @Published var didComplete = false
    private var addNoteType: AddNoteType
    
    init(noteModel: NoteModel?, addNoteType: AddNoteType) {
        if let noteModel = noteModel {
            self.noteModel = noteModel
        }
        self.addNoteType = addNoteType
    }
    
    func createNewNote() {
        noteModel.dateAdded = Date()
        print(noteModel)
        didComplete = true
    }
    
    func editedNote() {
        noteModel.dateAdded = Date()
        didComplete = true
    }
    
    func noteDateDetail() -> String {
        guard let date = noteModel.dateAdded else { return "" }
        let string = "\(date.toString(format: "MMM dd, yyyy")) at \(date.toString(format: "HH:mm"))"
        return string
    }
    
    func addingImage(_ image: UIImage) {
        let downTheLine = NSAttributedString(string: "\n")
        let fullString = NSMutableAttributedString(attributedString: noteModel.noteDetailAttributed)
//        let fullString = NSMutableAttributedString(attributedString: noteModel.noteDetailAttributed)
        
        let imageAttachment = NSTextAttachment()
        let imageSize = CGSize(width: UIScreen.screenWidth - 20, height: UIScreen.screenWidth - 20)
        imageAttachment.image = image.scalePreservingAspectRatio(targetSize: imageSize)
        
        let imageString = NSAttributedString(attachment: imageAttachment)
        fullString.append(downTheLine)
        fullString.append(imageString)
        fullString.append(downTheLine)
        
        withAnimation { [weak self] in
            guard let self = self else { return }
            self.noteModel.noteDetailAttributed = fullString
        }
    }
    
    func saveNote() {
        switch addNoteType {
        case .emptyGroup:
            print("Save to all notes")
        case .withGroup(let groupModel):
            print("Save to group: \(groupModel.name)")
            
        case .withAllGroup(let groupsModel):
            print("Choose one of the options")
        }
    }
}

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

class AddNewNoteViewModel: ObservableObject {
    
    @Published var noteModel = NoteModel(title: "", noteDetail: "", dateAdded: nil)
    @Published var didComplete = false
    
    init(noteModel: NoteModel?) {
        if let noteModel = noteModel {
            self.noteModel = noteModel
        }
    }
    
    func createNewNote() {
        noteModel.dateAdded = Date()
        print(noteModel)
        didComplete = true
    }
    
    func editedNote() {
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
}

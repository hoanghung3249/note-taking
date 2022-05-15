//
//  AppViewModel.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 14/05/2022.
//

import Foundation
import SwiftUI

final class AppViewModel: ObservableObject {
    
    @Published private(set) var groupNotes = [GroupNoteModel]()
    @Published private(set) var isLoading = true
    @Published var selectedNote = NoteModel(title: "", noteDetail: "", dateAdded: nil)
    @Published var didComplete = false
    
    func fetchGroupNote() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.groupNotes = mockingGroupNotes
            self.isLoading = false
        }
    }
    
    func setSelectedNote(_ selectedNote: NoteModel?) {
        if let selectedNote = selectedNote {
            self.selectedNote = selectedNote
        }
    }
    
    func removeSelectedNote() {
        self.selectedNote = NoteModel(title: "", noteDetail: "", dateAdded: nil)
    }
    
    func createNewNote() {
        self.selectedNote.dateAdded = Date()
        print(self.selectedNote)
        removeSelectedNote()
        didComplete = true
    }
    
    func editedNote() {
        self.selectedNote.dateAdded = Date()
        removeSelectedNote()
        didComplete = true
    }
    
    func noteDateDetail() -> String {
        guard let date = selectedNote.dateAdded else { return "" }
        let string = "\(date.toString(format: "MMM dd, yyyy")) at \(date.toString(format: "HH:mm"))"
        return string
    }
    
    func addingImage(_ image: UIImage) {
        let downTheLine = NSAttributedString(string: "\n")
        let fullString = NSMutableAttributedString(attributedString: selectedNote.noteDetailAttributed)
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
            self.selectedNote.noteDetailAttributed = fullString
        }
    }
}

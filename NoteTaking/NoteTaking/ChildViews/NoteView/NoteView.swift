//
//  NoteView.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 10/04/2022.
//

import SwiftUI

struct NoteView: View {
    
    var noteModel: NoteModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(noteModel.title)
                .lineLimit(3)
                .font(.system(size: 18, weight: .medium, design: .default))
            
            Text(noteModel.dateAdded?.dateAndTimetoString() ?? "")
                .font(.system(size: 16, weight: .light, design: .default))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        let noteModel = NoteModel(title: "Notes about learning flutter in 3 months. Notes about learning flutter", noteDetail: "Learning Future", dateAdded: Date())
        NoteView(noteModel: noteModel)
    }
}

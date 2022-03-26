//
//  GroupNoteView.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 26/03/2022.
//

import SwiftUI

struct GroupNoteView: View {
    
    var groupNote: GroupNoteModel
    
    var body: some View {
        HStack(spacing: 10) {
            Image(groupNote.groupNoteType.imageIconName)
            VStack(alignment: .leading, spacing: 5) {
                Text(groupNote.name)
                    .font(.headline.bold())
                
                Text("\(groupNote.numberOfNote)" + " \(groupNote.numberOfNote > 1 ? "notes" : "note")")
                    .foregroundColor(Color.gray)
                    .font(.callout.weight(.regular))
            }
            Spacer()
            Button(action: {}) {
                Image("dots")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
            }
        }
        .padding([.vertical,.horizontal])
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.white)
        )
    }
}

struct GroupNoteView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

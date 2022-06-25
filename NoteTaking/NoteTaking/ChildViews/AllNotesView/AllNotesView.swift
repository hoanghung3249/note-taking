//
//  AllNotesView.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 25/06/2022.
//

import SwiftUI

struct AllNotesView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            Image("main_folder")
            VStack(alignment: .leading, spacing: 5) {
                Text("All Notes")
                    .font(.headline.bold())
                
                Text("\(viewModel.totalOfNotes()) \(viewModel.totalOfNotes().toNoteFormat())")
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
                .foregroundColor(Color.whiteLilac.opacity(0.3))
        )
    }
}

struct AllNotesView_Previews: PreviewProvider {
    static var previews: some View {
        AllNotesView()
    }
}

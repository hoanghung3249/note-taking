//
//  AddNewNoteView.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 26/03/2022.
//

import SwiftUI

struct AddNewNoteView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel: AddNewNoteViewModel
    @State private var didStartEditing = false
    
    init(noteModel: NoteModel?) {
        _viewModel = .init(wrappedValue: AddNewNoteViewModel(noteModel: noteModel))
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 10) {
                headerView()
                titleInputView()
                    
                descInputView()
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    func headerView() -> some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("back")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
            }
            Spacer()
            Button(action: {
                viewModel.createNewNote()
            }) {
                Image("dots")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
            }
        }.padding(.horizontal)
    }
    
    @ViewBuilder
    func titleInputView() -> some View {
        TextField("", text: $viewModel.noteModel.title)
            .font(.system(size: 34).bold())
            .placeholder(when: viewModel.noteModel.title.isEmpty, placeholder: {
                Text("Title")
                    .font(.system(size: 34).bold())
                    .foregroundColor(.santasGray)
            })
            .padding()
    }
    
    @ViewBuilder
    func descInputView() -> some View {
        TextInputView(placeHolderText: "Type something...",
                      placeHolderColor: .santasGray,
                      textColor: .black,
                      maximumNumberOfLines: 0,
                      text: $viewModel.noteModel.noteDetail,
                      didStartEditing: $didStartEditing)
        .onTapGesture {
            didStartEditing = true
        }
        .padding()
    }
}

struct AddNewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewNoteView(noteModel: nil)
    }
}

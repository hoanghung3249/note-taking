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
            .onChange(of: viewModel.didComplete) { newValue in
                if newValue {
                    presentationMode.wrappedValue.dismiss()
                }
            }
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
            if viewModel.noteModel.dateAdded != nil {
                Button(action: {
                    viewModel.editedNote()
                }) {
                    Image("dots")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                }
            } else {
                Button(action: {
                    viewModel.createNewNote()
                }) {
                    Text("Save")
                        .foregroundColor(.black.opacity(0.5))
                        .font(.system(size: 18).bold())
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 13)
                                .foregroundColor(.periwinkleGray)
                        )
                }
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

//
//  AddNewNoteView.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 26/03/2022.
//

import SwiftUI

struct AddNewNoteView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
//    @StateObject private var viewModel: AddNewNoteViewModel
    @ObservedObject var viewModel: AppViewModel
    @State private var didStartEditing = false
    @State private var isOpenPhoto = false
    @State private var isShowToolBar = false
    
//    init(noteModel: NoteModel?, addNoteType: AddNoteType) {
//        _viewModel = .init(wrappedValue: AddNewNoteViewModel(noteModel: noteModel, addNoteType: addNoteType))
//        viewModel.setSelectedNote(noteModel)
//    }
    
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            KeyboardView(isShowToolBar: $isShowToolBar) {
                VStack(spacing: 10) {
                    headerView()
                    titleInputView()
                        .onTapGesture {
                            withAnimation {
                                isShowToolBar = false
                            }
                        }
                    
                    descInputView()
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .onChange(of: viewModel.didComplete) { newValue in
                    if newValue {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            } toolBar: {
                HStack {
                    Button {
                        isOpenPhoto.toggle()
                    } label: {
                        Image("image")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }

                    Button {
                        print("Adjust font size")
                    } label: {
                        Image("font-size-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                    Text("Done")
                }
                .padding()
            }
        }
        .sheet(isPresented: $isOpenPhoto, content: {
            ImagePicker(sourceType: .photoLibrary) { image in
                viewModel.addingImage(image)
            }
        })
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    func headerView() -> some View {
        HStack {
            // Back Button
            Button(action: {
                viewModel.removeSelectedNote()
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("back")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
            }
            
            // Note's date
            if viewModel.selectedNote.dateAdded != nil {
                Spacer()
                Text(viewModel.noteDateDetail())
                .foregroundColor(.scarpaFlow)
                .font(.headline.weight(.heavy))
                Spacer()
            } else {
                Spacer()
            }
            
            // Button Save/Edit
            if viewModel.selectedNote.dateAdded != nil {
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
        TextField("", text: $viewModel.selectedNote.title)
            .font(.system(size: 28).bold())
            .disableAutocorrection(true)
            .placeholder(when: viewModel.selectedNote.title.isEmpty, placeholder: {
                Text("Title")
                    .font(.system(size: 28).bold())
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
                      text: $viewModel.selectedNote.noteDetail,
                      didStartEditing: $didStartEditing,
                      textAttributed: $viewModel.selectedNote.noteDetailAttributed)
        .onTapGesture {
            didStartEditing = true
            withAnimation {
                isShowToolBar = true
            }
        }
        .onAppear {
            if !viewModel.selectedNote.noteDetail.isEmpty {
                didStartEditing = true
            }
        }
        .padding()
    }
}

struct AddNewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewNoteView(viewModel: AppViewModel())
    }
}

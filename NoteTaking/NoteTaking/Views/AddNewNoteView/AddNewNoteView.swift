//
//  AddNewNoteView.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 26/03/2022.
//

import SwiftUI

struct AddNewNoteView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: AppViewModel
    @State private var didStartEditing = false
    @State private var isOpenPhoto = false
    @State private var isShowToolBar = false
    @State private var sliderValue: Double = 20
    @State private var isShowSlider = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            KeyboardView(isShowToolBar: $isShowToolBar) {
                VStack(spacing: 10) {
                    headerView()
                    titleInputView()
                        .onTapGesture {
                            withAnimation { isShowToolBar = false }
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
                VStack {
                    if isShowSlider {
                        fontSizeSliderToolBarView()
                    } else {
                        mainToolBarView()
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $isOpenPhoto, content: {
            ImagePicker(sourceType: .photoLibrary) { image in
                withAnimation {
                    viewModel.addingImage(image)
                }
            }
        })
        .navigationBarHidden(true)
    }
}

private extension AddNewNoteView {
    
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
                                .foregroundColor(
                                    viewModel.selectedNote.title.isEmpty ? Color.periwinkleGray.opacity(0.2) : Color.periwinkleGray
                                )
                        )
                }
                .disabled(viewModel.selectedNote.title.isEmpty)
            }
            
        }.padding(.horizontal)
    }
    
    @ViewBuilder
    func titleInputView() -> some View {
        TextField("", text: $viewModel.selectedNote.title)
            .font(.system(size: 28).bold())
            .keyboardType(.alphabet)
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
                      textAttributed: $viewModel.selectedNote.noteDetailAttributed,
                      fontSize: $sliderValue)
        .onTapGesture {
            didStartEditing = true
            withAnimation { isShowToolBar = true }
        }
        .onAppear {
            if !viewModel.selectedNote.noteDetail.isEmpty {
                didStartEditing = true
            }
        }
        .padding()
    }
    
    @ViewBuilder
    func mainToolBarView() -> some View {
        HStack {
            Button {
                withAnimation { isOpenPhoto.toggle() }
            } label: {
                Image("image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            }

            Button {
                withAnimation { isShowSlider.toggle() }
            } label: {
                Image("font-size-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            }
            
            Spacer()
            Text("Done")
                .foregroundColor(.wistfulapprox)
                .font(.system(size: 18, weight: .bold, design: .default))
        }
    }
    
    @ViewBuilder
    func fontSizeSliderToolBarView() -> some View {
        HStack {
            Text("A")
                .font(.system(size: 12))
            
            Slider(value: $sliderValue, in: 10...32, step: 1)
                .accentColor(.periwinkleGray)
            
            Text("A")
                .font(.system(size: 32))
            
            Button {
                withAnimation { isShowSlider.toggle() }
            } label: {
                Text("Done")
                    .foregroundColor(.wistfulapprox)
                    .font(.system(size: 18, weight: .bold, design: .default))
            }
        }
        .transition(.move(edge: .bottom))
    }
    
}

struct AddNewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewNoteView(viewModel: AppViewModel())
    }
}

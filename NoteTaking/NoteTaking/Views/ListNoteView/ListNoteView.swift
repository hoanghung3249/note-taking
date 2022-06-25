//
//  ListNoteView.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 10/04/2022.
//

import SwiftUI

struct ListNoteView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appViewModel: AppViewModel
    @ObservedObject var viewModel: ListNoteViewModel
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                headerView()
                listNotes()
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
                Image(uiImage: R.image.back()!)
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
            }
            
            Spacer()
            
            Text(viewModel.listNotesModel?.name ?? "")
                .foregroundColor(.scarpaFlow)
                .font(.system(size: 20, weight: .semibold, design: .default))
            
            Spacer()
            
            Button(action: {
                
            }) {
                Image(uiImage: R.image.dots()!)
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func listNotes() -> some View {
        if let groupNoteModel = viewModel.listNotesModel {
            ScrollView {
                ForEach(groupNoteModel.notes) { note in
                    NavigationLink(destination: AddNewNoteView(viewModel: appViewModel), label: {
                        NoteView(noteModel: note)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.whiteLilac.opacity(0.7))
                            )
                    })
                    .simultaneousGesture(TapGesture().onEnded({ _ in
                        print(note)
                        appViewModel.setSelectedNote(note)
                    }))
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal)
        } else {
            EmptyView()
        }
    }
}

struct ListNoteView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//
//  HomeView.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 26/03/2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                if viewModel.isLoading {
                    VerticalBar(barColor: .newOrleans)
                } else {
                    VStack {
                        headerView()
                        Spacer()
                        bodyView()
                        if viewModel.groupNotes.isEmpty {
                            Spacer()
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                    
                    VStack {
                        HStack {
                            NavigationLink(destination: AddNewNoteView(noteModel: nil)) {
                                Image("plus")
                                    .resizable()
                                    .frame(width: 70, height: 70, alignment: .center)
                                    .shadow(color: .royalBlue, radius: 3.5, x: 0, y: 1)
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.fetchGroupNote()
        }
    }
    
    @ViewBuilder
    func headerView() -> some View {
        HStack {
            HStack {
                Image("avatar")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .clipShape(Circle())
                
                Text("Henry")
                    .font(.headline.weight(.heavy))
            }
            Spacer()
            
            Button(action: {}) {
                Image("loupe")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func emptyMessageView() -> some View {
        VStack(spacing: 10) {
            Image("paperwork")
                
            Text("Empty list!")
                .font(.largeTitle.weight(.semibold))
            
            Text("Click the button to write something exciting!")
                .font(.callout.weight(.medium))
        }
        .padding()
    }
    
    @ViewBuilder
    func listNotes() -> some View {
        ScrollView {
            ForEach(viewModel.groupNotes) { note in
                NavigationLink(destination: ListNoteView(viewModel: ListNoteViewModel(groupNoteModel: note))) {
                    GroupNoteView(groupNote: note)
                }
                // Show plain button without navigationlink overlay
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func bodyView() -> some View {
        if !viewModel.groupNotes.isEmpty {
            listNotes()
        } else {
            emptyMessageView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

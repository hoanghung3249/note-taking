//
//  HomeView.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 26/03/2022.
//

import SwiftUI
import Rswift

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @State private var isShownPopUp = false
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                if appViewModel.isLoading {
                    VerticalBar(barColor: .newOrleans)
                } else {
                    VStack {
                        headerView()
                        Spacer()
                        bodyView()
                        if appViewModel.groupNotes.isEmpty {
                            Spacer()
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                    
                    VStack {
                        HStack {
                            NavigationLink(destination: AddNewNoteView(viewModel: appViewModel)) {
                                Image(uiImage: R.image.plus()!)
                                    .resizable()
                                    .frame(width: 60, height: 60, alignment: .center)
                                    .shadow(color: .royalBlue, radius: 3.5, x: 0, y: 1)
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .environmentObject(appViewModel)
            .navigationBarHidden(true)
            .popUp(isPresented: isShownPopUp, alignment: .center) {
                Color.green.frame(width: 100, height: 100, alignment: .center)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            appViewModel.fetchGroupNote()
        }
    }
    
    @ViewBuilder
    func headerView() -> some View {
        HStack {
            HStack {
                Image(uiImage: R.image.avatar()!)
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .clipShape(Circle())
                
                Text("Henry")
                    .font(.headline.weight(.heavy))
            }
            Spacer()
            
            Button(action: {
                isShownPopUp.toggle()
            }) {
                Image(uiImage: R.image.loupe()!)
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func emptyMessageView() -> some View {
        VStack(spacing: 10) {
            Image(uiImage: R.image.paperwork()!)
                
            Text("Empty list!")
                .font(.largeTitle.weight(.semibold))
            
            Text("Click the button to write something exciting!")
                .font(.callout.weight(.medium))
        }
        .padding()
    }
    
    @ViewBuilder
    func listNotes() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                AllNotesView()
                Divider()
                ForEach(appViewModel.groupNotes) { note in
                    NavigationLink(destination: ListNoteView(viewModel: ListNoteViewModel(groupNoteModel: note))) {
                        GroupNoteView(groupNote: note)
                    }
                    // Show plain button without navigationlink overlay
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
    
    @ViewBuilder
    func bodyView() -> some View {
        if !appViewModel.groupNotes.isEmpty {
            listNotes()
        } else {
            emptyMessageView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    @StateObject static var viewModel = AppViewModel()
    static var previews: some View {
        Group {
            HomeView()
                .environmentObject(viewModel)
        }
    }
}

//
//  AddNewNoteView.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 26/03/2022.
//

import SwiftUI

struct AddNewNoteView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                headerView()
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
            Button(action: {}) {
                Image("dots")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
            }
        }.padding(.horizontal)
    }
}

struct AddNewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

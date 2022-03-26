//
//  HomeView.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 26/03/2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.whiteLilac.ignoresSafeArea()
            VStack {
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
                
                Spacer()
                
                VStack(spacing: 10) {
                    Image("paperwork")
                        
                    Text("Empty list!")
                        .font(.largeTitle.weight(.semibold))
                    
                    Text("Click the button to write something exciting!")
                        .font(.callout.weight(.medium))
                }
                .padding()
                Spacer()
                
                HStack {
                    Button(action: {}) {
                        Image("plus")
                            .resizable()
                            .frame(width: 75, height: 75, alignment: .center)
                    }
                    
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

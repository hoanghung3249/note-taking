//
//  NoteAppPopUpView.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 23/04/2022.
//

import Foundation
import SwiftUI

struct NoteAppPopUpView<T: View>: ViewModifier {
    
    let popUp: T
    let isPresented: Bool
    let alignment: Alignment
    
    init(isPresented: Bool, alignment: Alignment, @ViewBuilder content: () -> T) {
        self.isPresented = isPresented
        self.alignment = alignment
        popUp = content()
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(popupContent())
    }
    
    @ViewBuilder private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                popUp
                    .animation(.spring())
                    .transition(.offset(x: 0, y: geometry.belowScreenEdge))
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
            }
        }
    }
    
}

private extension GeometryProxy {
    var belowScreenEdge: CGFloat {
        UIScreen.main.bounds.height - frame(in: .global).minY
    }
}

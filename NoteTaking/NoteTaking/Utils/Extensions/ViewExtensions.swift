//
//  ViewExtensions.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 09/04/2022.
//

import Foundation
import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
    
    @ViewBuilder public func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
    
    func popUp<T: View>(isPresented: Bool,
                        alignment: Alignment = .center,
                        @ViewBuilder content: () -> T) -> some View {
        modifier(NoteAppPopUpView(isPresented: isPresented, alignment: alignment, content: content))
    }
}

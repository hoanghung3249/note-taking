//
//  KeyBoardToolBarView.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 23/04/2022.
//

import Foundation
import SwiftUI

final class KeyboardResponder: ObservableObject {
    
    private var notificationCenter: NotificationCenter
    @Published private(set) var currentHeight: CGFloat = 0

    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func dismiss() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            withAnimation { [weak self] in
                guard let self = self else { return }
                self.currentHeight = keyboardSize.height
            }
        }
    }

    @objc func keyBoardWillHide(notification: Notification) {
        withAnimation { [weak self] in
            guard let self = self else { return }
            self.currentHeight = 0
        }
    }
}

struct KeyboardView<Content, ToolBar> : View where Content : View, ToolBar: View {
    @StateObject private var keyboard: KeyboardResponder = KeyboardResponder()
    let toolbarFrame: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 40.0)
    @Binding var isShowToolBar: Bool
    var content: () -> Content
    var toolBar: () -> ToolBar
    
    var body: some View {
        ZStack {
            content()
                .padding(.bottom, (keyboard.currentHeight == 0) ? 0 : toolbarFrame.height)
            VStack {
                 Spacer()
                 toolBar()
                    .frame(width: toolbarFrame.width, height: toolbarFrame.height)
                    .background(Color.whiteLilac)
                    .hidden(!isShowToolBar)
                    .cornerRadius(5, corners: [.topLeft, .topRight])
            }
            .opacity((keyboard.currentHeight == 0) ? 0 : 1)
            .animation(.easeOut)
        }
        .padding(.bottom, keyboard.currentHeight)
        .edgesIgnoringSafeArea(.bottom)
        .animation(.easeOut)
        
    }
}

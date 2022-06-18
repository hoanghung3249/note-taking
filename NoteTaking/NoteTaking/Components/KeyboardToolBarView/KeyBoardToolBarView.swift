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
    @Published private(set) var visible: Bool = false

    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
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
            self.visible = false
        }
    }
    
    @objc func keyBoardDidShow(notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            withAnimation(.spring()) {
                self.visible = true
            }
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
                .padding(.bottom, keyboard.visible ? toolbarFrame.height : 0)
            VStack {
                 Spacer()
                 toolBar()
                    .frame(width: toolbarFrame.width, height: toolbarFrame.height)
                    .background(Color.whiteLilac)
                    .opacity(keyboard.visible ? 1 : 0)
                    .hidden(!isShowToolBar)
                    .cornerRadius(5, corners: [.topLeft, .topRight])
            }
            .opacity(keyboard.visible ? 1 : 0)
            .animation(.easeOut)
        }
        .padding(.bottom, keyboard.currentHeight)
        .edgesIgnoringSafeArea(.bottom)
        .animation(.easeOut)
        
    }
}

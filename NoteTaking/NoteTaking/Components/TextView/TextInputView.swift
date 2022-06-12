//
//  TextInputView.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 27/03/2022.
//

import Foundation
import UIKit
import SwiftUI

struct TextInputView: UIViewRepresentable {
    
    typealias UIViewType = UITextView
    
    var placeHolderText: String
    var placeHolderColor: Color
    var textColor: Color
    var maximumNumberOfLines: Int
    
    @Binding var text: String
    @Binding var didStartEditing: Bool
    @Binding var textAttributed: NSAttributedString
    @Binding var fontSize: Double
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        if !textAttributed.string.isEmpty {
//            textView.text = text
            textView.attributedText = textAttributed
            textView.textColor = UIColor(textColor)
            textView.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        } else {
            textView.text = placeHolderText
            textView.textColor = UIColor(placeHolderColor)
            textView.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        }
        textView.isUserInteractionEnabled = true
        textView.textContainer.maximumNumberOfLines = maximumNumberOfLines
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = true
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.isScrollEnabled = true 
        canPerformActionOn(textView, canPerform: false)
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        canPerformActionOn(uiView, canPerform: true)
        if didStartEditing {
            uiView.attributedText = self.textAttributed
            uiView.textColor = UIColor(textColor)
            uiView.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        } else {
            uiView.text = placeHolderText
            uiView.textColor = UIColor(placeHolderColor)
            uiView.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    private func canPerformActionOn(_ textView: UITextView, canPerform: Bool) {
        textView.isEditable = canPerform
        textView.isSelectable = canPerform
    }
}

extension TextInputView {
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextInputView
        
        init(parent: TextInputView) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.placeHolderText {
                textView.text = ""
                textView.textColor = UIColor(parent.textColor)
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.attributedText.string.isEmpty {
                textView.text = parent.placeHolderText
                textView.textColor = UIColor(parent.placeHolderColor)
                textView.font = UIFont.systemFont(ofSize: 34, weight: .bold)
                self.parent.didStartEditing = false
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.textAttributed = textView.attributedText
        }
    }
    
}

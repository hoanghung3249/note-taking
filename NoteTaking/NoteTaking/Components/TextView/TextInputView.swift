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
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        if !textAttributed.string.isEmpty {
//            textView.text = text
            textView.attributedText = textAttributed
            textView.textColor = UIColor(textColor)
            textView.font = UIFont.systemFont(ofSize: 20, weight: .medium)
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
        
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if didStartEditing {
            uiView.attributedText = self.textAttributed
            uiView.textColor = UIColor(textColor)
            uiView.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        } else {
            uiView.text = placeHolderText
            uiView.textColor = UIColor(placeHolderColor)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
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
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.textAttributed = textView.attributedText
        }
        
//        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            
//            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
//            let attributedString = NSAttributedString(string: text)
//            let mutableString = NSMutableAttributedString(attributedString: textAttributed.wrappedValue)
//            mutableString.append(attributedString)
            
//            print(mutableString)
//            
//            self.textAttributed.wrappedValue = mutableString
//            let cursor = NSRange(location: textView.selectedRange.location + 1, length: 0)
//            textView.selectedRange = cursor
//            if mutableString.containsAttachments(in: range) {
//                textView.textStorage.insert(attributedString, at: range.location)
//                let cursor = NSRange(location: textView.selectedRange.location + 1, length: 0)
//                textView.selectedRange = cursor
//            } else {
//                textView.attributedText = mutableString
//            }
//            return true
//            if text.count > 0 {
//                let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
//                textView.text = newText
//                return true
//            } else {
//                let attributedString = NSMutableAttributedString(string: text)
//                textView.textStorage.insert(attributedString, at: range.location)
//                let cursor = NSRange(location: textView.selectedRange.location + 1, length: 0)
//                textView.selectedRange = cursor
//            }
//            return true
//        }
    }
    
}

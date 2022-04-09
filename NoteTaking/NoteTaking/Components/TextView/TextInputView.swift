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
    var textDidChange: (UITextView) -> Void
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.text = placeHolderText
        textView.textColor = UIColor(placeHolderColor)
        textView.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        textView.isUserInteractionEnabled = true
        textView.textContainer.maximumNumberOfLines = maximumNumberOfLines
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = true
        textView.isScrollEnabled = true 
        
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = placeHolderText
        uiView.textColor = UIColor(placeHolderColor)
        DispatchQueue.main.async {
            self.textDidChange(uiView)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, placeHolderColor: placeHolderColor, textColor: textColor, placeHolderText: placeHolderText, textViewDidChange: textDidChange)
    }
}

extension TextInputView {
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding private var text: String
        let placeHolderColor: Color
        let placeHolderText: String
        let textColor: Color
        var textDidChange: (UITextView) -> Void
        
        init(text: Binding<String>, placeHolderColor: Color, textColor: Color, placeHolderText: String, textViewDidChange: @escaping (UITextView) -> Void) {
            _text = text
            self.placeHolderColor = placeHolderColor
            self.textColor = textColor
            self.placeHolderText = placeHolderText
            self.textDidChange = textViewDidChange
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor(placeHolderColor) {
                textView.text = ""
                textView.textColor = UIColor(textColor)
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = placeHolderText
                textView.textColor = UIColor(placeHolderColor)
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.text = textView.text
            self.textDidChange(textView)
        }
    }
    
}

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
        if didStartEditing {
            uiView.text = self.text
            uiView.textColor = UIColor(textColor)
            uiView.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        } else {
            uiView.text = placeHolderText
            uiView.textColor = UIColor(placeHolderColor)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, placeHolderColor: placeHolderColor, textColor: textColor, placeHolderText: placeHolderText)
    }
}

extension TextInputView {
    
    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        let placeHolderColor: Color
        let placeHolderText: String
        let textColor: Color
        
        init(text: Binding<String>, placeHolderColor: Color, textColor: Color, placeHolderText: String) {
            self.text = text
            self.placeHolderColor = placeHolderColor
            self.textColor = textColor
            self.placeHolderText = placeHolderText
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == placeHolderText {
                textView.text = ""
                textView.textColor = UIColor(textColor)
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = placeHolderText
                textView.textColor = UIColor(placeHolderColor)
                textView.font = UIFont.systemFont(ofSize: 34, weight: .bold)
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.text.wrappedValue = textView.text
        }
    }
    
}

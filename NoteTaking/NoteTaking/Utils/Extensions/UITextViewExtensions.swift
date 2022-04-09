//
//  UITextViewExtensions.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 27/03/2022.
//

import Foundation
import UIKit

extension UITextView {
    func sizeFit(width: CGFloat) -> CGSize {
        let fixedWidth = width
        let newSize = sizeThatFits(CGSize(width: fixedWidth, height: .greatestFiniteMagnitude))
        return CGSize(width: fixedWidth, height: newSize.height)
    }

    func numberOfLine() -> Int {
        let size = self.sizeFit(width: self.bounds.width)
        let numLines = Int(size.height / (self.font?.lineHeight ?? 1.0))
        return numLines
    }
}

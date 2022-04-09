//
//  VerticalIndicatorView.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 09/04/2022.
//

import Foundation
import SwiftUI

struct VerticalBar: View {
    @State private var shouldAnimate: Bool = false
    var barColor: Color
    
    var body: some View {
        
        HStack(alignment: .center, spacing: shouldAnimate ? 15 : 5) {
            Capsule(style: .continuous)
                .fill(barColor)
                .frame(width: 10, height: 50)
            Capsule(style: .continuous)
                .fill(barColor)
                .frame(width: 10, height: 30)
            Capsule(style: .continuous)
                .fill(barColor)
                .frame(width: 10, height: 50)
            Capsule(style: .continuous)
                .fill(barColor)
                .frame(width: 10, height: 30)
            Capsule(style: .continuous)
                .fill(barColor)
                .frame(width: 10, height: 50)
        }
        .frame(width: shouldAnimate ? 150 : 100)
        .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: shouldAnimate)
        .onAppear {
            DispatchQueue.main.async {
                self.shouldAnimate = true
            }
        }
    }
}

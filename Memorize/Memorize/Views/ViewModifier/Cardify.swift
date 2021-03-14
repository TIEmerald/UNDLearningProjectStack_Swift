//
//  Cardify.swift
//  Memorize
//
//  Created by UNDaniel on 14/3/21.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool = false
    
    func body(content: Content) -> some View {
        ZStack(content: {
            if self.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        })
    }
    
    // MARK: - Constants
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

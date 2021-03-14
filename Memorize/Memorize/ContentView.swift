//
//  ContentView.swift
//  Memorize
//
//  Created by UNDaniel on 10/1/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel : EmojiMemoryGame
    var body: some View {
        Grid(items: viewModel.cards) { card in
            CardView(card: card).onTapGesture{
                viewModel.choose(card: card)
            }
        }
        .foregroundColor(Color.orange)
        .padding()
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader(content: { geometry in
            self.body(for: geometry.size)
        })
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack(content: {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90), clockwise: true)
                    .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            })
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    
    // MARK: - Drawing Constants
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.70
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[2])
        return ContentView(viewModel: game)
    }
}

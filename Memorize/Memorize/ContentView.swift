//
//  ContentView.swift
//  Memorize
//
//  Created by UNDaniel on 10/1/21.
//

import SwiftUI

struct ContentView: View {
    var viewModel : EmojiMemoryGame
    var body: some View {
        return HStack(content: {
            ForEach(viewModel.cards, content: { card in
                CardView(card: card).onTapGesture{
                    viewModel.choose(card: card)
                }
            })
        })
            .foregroundColor(Color.orange)
            .padding()
            .font(Font.largeTitle)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        ZStack(content: {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3.0)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}

//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by UNDaniel on 2021/1/15.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var game: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return game.cards
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
}

//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by UNDaniel on 2021/1/15.
//

import Foundation

class EmojiMemoryGame {
    
    private var game: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    class func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 2) { _ in "😀" }
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

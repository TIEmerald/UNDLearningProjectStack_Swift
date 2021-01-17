//
//  MemoryGame.swift
//  Memorize
//
//  Created by UNDaniel on 2021/1/15.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        print("card chosen: \(card)")
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for index in 0..<numberOfPairsOfCards {
            cards.append(Card(isFaceUp: false, isMatched: false, content: cardContentFactory(index), id: 2*index))
            cards.append(Card(isFaceUp: false, isMatched: false, content: cardContentFactory(index), id: 2*index + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
        
        var id: Int
    }
}


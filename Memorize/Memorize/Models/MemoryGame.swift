//
//  MemoryGame.swift
//  Memorize
//
//  Created by UNDaniel on 2021/1/15.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter{ cards[$0].isFaceUp }
            return faceUpCardIndices.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = self.cards.firstIndex(matching: card),
           !self.cards[chosenIndex].isFaceUp,
           !self.cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
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


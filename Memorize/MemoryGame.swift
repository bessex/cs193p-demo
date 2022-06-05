//
//  MemoryGame.swift
//  Memorize
//
//  Created by Ben Essex and Paul Haggerty on 03 Jun 22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private(set) var score = 0
    
    private var indexOfOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.single() }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfOnlyFaceUpCard {
                if cards[chosenIndex].matches(cards[potentialMatchIndex]) {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                cards.indices.filter { cards[$0].isFaceUp && !cards[$0].isMatched }
                    .forEach {
                        if cards[$0].hasBeenSeen {
                            score -= 1
                        }
                        cards[$0].hasBeenSeen = true
                    }
                indexOfOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards to card array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var hasBeenSeen = false
        let content: CardContent
        let id: Int
        
        func matches(_ other: Card) -> Bool {
            self.content == other.content
        }
    }
}

extension Collection {
    func single() -> Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}

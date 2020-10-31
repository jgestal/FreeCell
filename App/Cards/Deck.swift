//
//  Deck.swift
//  Solitaire
//
//  Created by Juan on 08/06/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import Foundation

final class Deck {
    
    static public func allCards() -> [Card] {
        
        var cards = [Card]()
        
        for r in Rank.allCases {
            for s in Suit.allCases {
                cards.append(Card(rank: r, suit: s))
            }
        }
        /*
        for s in Suit.allCases {
            for r in Rank.allCases {
                cards.append(Card(rank: r, suit: s))
            }
        }*/
        
        return cards
    }
    
    private var cards : [Card]
 
    init(cards: [Card]) {
        self.cards = cards
    }
    
    func shuffle() {
         cards = cards.shuffled()
    }
     
    func getCard() -> Card? {
        cards.count > 0 ? cards.remove(at: cards.count - 1) : nil
    }
    
    func isEmpty() -> Bool {
        return cards.count <= 0
    }
    
    func get(amount: Int) -> [Card]? {
        let leftSplit = cards[0..<amount]
        let rightSplit = cards[amount..<cards.count]
        cards = Array(rightSplit)
        return Array(leftSplit).reversed()
    }
}

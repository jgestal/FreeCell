//
//  FreecellGameGenerator.swift
//  OSX
//
//  Created by Juan on 12/06/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//
// Thanks to Rosetta Code for the deal algorithm
// - https://rosettacode.org/wiki/Deal_cards_for_FreeCell#Swift
//

import Foundation

final class FreecellGameGenerator {
    
    // 1 to 32000
    static func getDeck(seed: Int) -> Deck {
        
        var cards = [Card]()
        
        for i in (0..<52).reversed() {
            cards.append(getCard(sequence: i))
        }
        
        struct MicrosoftLinearCongruentialGenerator {
            var seed : Int
            mutating func next() -> Int {
                self.seed = (self.seed * 214013 + 2531011) % (Int(Int32.max)+1)
                return self.seed >> 16
            }
        }
        
        var r = MicrosoftLinearCongruentialGenerator(seed: seed)
               
        for i in 0..<51 {
            cards.swapAt(i, 51-r.next()%(52-i))
        }
        
        return Deck(cards: cards.reversed())
    }
    
    private static func getCard(sequence n: Int) -> Card {
        return Card(rank: Rank.allCases[n/4], suit: Suit.allCases[n%4])
    }
}

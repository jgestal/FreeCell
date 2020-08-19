//
//  TakeRule.swift
//  Solitaire
//
//  Created by Juan on 12/08/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import Foundation

protocol TakeRule {
    func comply(source: [Card], from card: Card) -> Bool
}


final class TakeRule_CanTakeLastCard: TakeRule {
    
    func comply(source: [Card], from card: Card) -> Bool {
        source.last == card
    }
}

final class TakeRule_TakeIfNextCardsAreDescentCardsFromOppositeColors: TakeRule {
    
    func comply(source: [Card], from card: Card) -> Bool {

        if card == source.last { return true }
         
        guard let index = source.firstIndex(of: card) else { return false }
             
        let nextCard = source[index + 1]
         
        return card.rank.rawValue - 1 == nextCard.rank.rawValue &&
               card.suit.color != nextCard.suit.color &&
               comply(source: source, from: nextCard)
        
    }
}

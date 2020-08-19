//
//  InteractivePile.swift
//  Solitaire
//
//  Created by Juan on 11/06/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import SpriteKit

class InteractivePile: Pile {
    
    let acceptRules : [AcceptRule]
    let takeRules: [TakeRule]
    
    init(offset: CGSize, position: CGPoint, acceptRules: [AcceptRule], takeRules: [TakeRule], texture: SKTexture) {
        self.acceptRules = acceptRules
        self.takeRules = takeRules
        super.init(offset: offset, position: position, texture: texture)
    }
    
    required init?(coder aDecoders: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func canAccept(cards: [Card]) -> Bool {
        return acceptRules.reduce(false) { $0 || $1.comply(source: cards, target: self.cards) }
    }
    
    func accept(cards: [Card]) -> Bool {
        guard canAccept(cards: cards) else { return false }
        add(cards: cards)
        return true
    }

    func canTake(from card: Card) -> Bool {
        return takeRules.reduce(false) { $0 || $1.comply(source: cards, from: card) }
    }

    
    func add(cards: [Card]) {
        self.cards += cards
    }
    
    func remove(cards: [Card]) {
        cards.forEach {
            if let index = self.cards.firstIndex(of: $0) {
                self.cards.remove(at: index)
            }
        }
    }
    
    func moveFrom(card: Card) -> Move? {
        
        guard let index = cards.firstIndex(of: card), canTake(from: card) else { return nil }
       
        let leftSplit = Array(cards[0..<index])
        let rightSplit = Array(cards[index..<cards.count])
        
        cards = leftSplit
        
        updateCards()

        return Move(source: self, cards: rightSplit, position: card.position)
    }
}


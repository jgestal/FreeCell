//
//  InteractivePile.swift
//  Solitaire
//
//  Created by Juan on 11/06/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import SpriteKit

class InteractivePile: Pile {
    
    static func createCascade() -> InteractivePile {
        
        return InteractivePile(offset: CGSize(width: 0, height: -30),
                                acceptRules: [Rule_SourceLastCardIsOppositeColorAndPreviousRank(),
                                               Rule_IfTargetIsEmpty_AcceptAll()],
                                takeRules: [TakeRule_TakeIfNextsAreDescentCardsFromOppositeColors()],
                                texture: SKTexture.init(imageNamed: "cascade"))
    }
    
    static func createFoundation() -> InteractivePile {
        
        return InteractivePile(offset: CGSize(width: 0, height: 0),
                                 acceptRules: [Rule_TargetIsEmpty_SourceIsAnAce(),
                                               Rule_SourceCardIsNextRankFromSameSuit()],
                                 takeRules: [TakeRule_TakeLast()],
                                 texture: SKTexture.init(imageNamed: "foundation"))
    }
    
    static func createOpenCell() -> InteractivePile {
        return InteractivePile(offset: CGSize(width: 0, height: 0),
                                     acceptRules: [Rule_AcceptOnlyOneCard()],
                                     takeRules: [TakeRule_TakeLast()],
                                     texture: SKTexture.init(imageNamed: "open_cell"))

    }

    let acceptRules : [AcceptRule]
    let takeRules: [TakeRule]
    
    init(offset: CGSize, acceptRules: [AcceptRule], takeRules: [TakeRule], texture: SKTexture) {
        self.acceptRules = acceptRules
        self.takeRules = takeRules
        super.init(offset: offset, texture: texture)
    }
    
    required init?(coder aDecoders: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func canAccept(cards: [Card]) -> Bool {
        return acceptRules.reduce(false) { $0 || $1.complyRule(target: self.cards, source: cards) }
    }

    func canTake(card: Card) -> Bool {
        return takeRules.reduce(false) { $0 || $1.complyRule(source: cards, from: card) }
    }

    func accept(cards: [Card]) {
        guard canAccept(cards: cards) else { fatalError("The stack doesn't comply accept rules") }
        add(cards: cards)
        updateCardsPosition(animated: true)
    }
    
    func add(cards: [Card]) {
        self.cards += cards
        updateCardsPosition(animated: true)
    }
    
    func moveStackFromCard(card: Card) -> Movement? {
        
        guard let index = cards.firstIndex(of: card), canTake(card: card) else { return nil }
       
        let leftSplit = cards[0..<index]
        let rightSplit = cards[index..<cards.count]
        
        cards = Array(leftSplit)
        
        updateCardsPosition()

        return Movement(origin: self, cards: Array(rightSplit), position: card.position)
    }
}


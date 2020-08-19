//
//  MoveStack.swift
//  Solitaire
//
//  Created by Juan on 11/06/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import SpriteKit

class Move: Pile {
    
    static let KZPos : CGFloat = 100
    static let KOffset = CGSize(width: 0, height: -30)

    var source: InteractivePile
    var target: InteractivePile?
    
    init(source: InteractivePile, cards: [Card], position: CGPoint) {
        
        self.source = source
        
        super.init(offset: Move.KOffset, position: position, texture: SKTexture.init())
        
        self.cards = cards
        zPosition = Move.KZPos
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cancel() {
        source.add(cards: cards)
        source.updateCards(animated: true)
    }
    
    func moveCards(target: InteractivePile) {
        self.target = target
        target.add(cards: cards)
    }
    
    func revert() {
        self.target?.remove(cards: cards)
        self.source.add(cards: cards)
    }
}


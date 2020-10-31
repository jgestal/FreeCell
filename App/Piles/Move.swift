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

    var origin: InteractivePile
    var destination: InteractivePile?
    
    init(source: InteractivePile, cards: [Card], position: CGPoint) {
        
        self.origin = source
        
        super.init(offset: Move.KOffset, position: position, texture: SKTexture.init())
        
        self.cards = cards
        zPosition = Move.KZPos
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cancel() {
        origin.add(cards: cards)
        origin.updateCards(animated: true)
    }
    
    func moveCards(destination: InteractivePile) {
        self.destination = destination
        destination.add(cards: cards)
        destination.updateCards(animated: true)
    }
    
    func revert() {
        self.destination?.remove(cards: cards)
        self.origin.add(cards: cards)
    }
}


//
//  MoveStack.swift
//  Solitaire
//
//  Created by Juan on 11/06/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import SpriteKit

class Move: Pile {

    var origin: InteractivePile
    var destination: InteractivePile?
    
    init(origin: InteractivePile, cards: [Card], position: CGPoint) {
        
        self.origin = origin
        
        super.init(offset: CGSize(width: 0, height: -30), texture: SKTexture.init(imageNamed:""))
        
        self.position = position
        zPosition = 100
        self.cards = cards
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


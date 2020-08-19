//
//  StackSprite.swift
//  Solitaire
//
//  Created by Juan on 09/06/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import SpriteKit


class SpriteStack: SKSpriteNode {
    
    private(set) var cards: [Card]!

    init(stack: Stack) {
        
        self.stack = stack
        
        let texture = SKTexture.init(imageNamed: "stack")
        super.init(texture: texture, color: .clear, size: CGSize(width: texture.size().width / 6, height: texture.size().height / 6))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

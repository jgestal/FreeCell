//
//  CardSprite.swift
//  Solitaire
//
//  Created by Juan on 09/06/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import SpriteKit

class SpriteCard: SKSpriteNode {
    
    let card : Card!
    
    init(card: Card) {
        self.card = card
        let texture = SKTexture.init(imageNamed: card.description)
        super.init(texture: texture, color: .clear, size: CGSize(width: texture.size().width / 6, height: texture.size().height / 6))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

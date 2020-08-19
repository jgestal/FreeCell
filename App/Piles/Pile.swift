//
//  StackSprite.swift
//  Solitaire
//
//  Created by Juan on 09/06/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import SpriteKit

let KAnimationDuration : TimeInterval = 0.15

class Pile: SKSpriteNode {
    
    let offset : CGSize!
    
    var cards = [Card]() 
    
    init(offset : CGSize, position: CGPoint, texture: SKTexture) {
        
        self.offset = offset
        
        super.init(texture: texture, color: .clear, size: CGSize(width: texture.size().width / 9, height: texture.size().height / 9))
        
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
    }
    
    public func updateCards(animated: Bool = false) {

        for (i, card) in cards.enumerated() {
            card.pile = self
            
            let destination = CGPoint(x: position.x + offset.width * CGFloat(i), y: position.y + offset.height * CGFloat(i))
            let newZPosition = zPosition + CGFloat(i + 1)
            
            if animated {
                
                card.zPosition = 1000 + CGFloat(i + 1)
                
                let moveAction = SKAction.move(to: destination, duration: KAnimationDuration)
                let updateZPositionAction = SKAction.run( {
                    card.zPosition = newZPosition
                })

                let moveSequence = SKAction.sequence([moveAction,updateZPositionAction])
                card.run(moveSequence)
            
            } else {
                card.position = destination
                card.zPosition = newZPosition
            }
        }
    }
}


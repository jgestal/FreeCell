//
//  Card+Animations.swift
//  Solitaire
//
//  Created by Juan on 18/08/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import SpriteKit


extension Card {
    
    func pickUpAnimation() {
        
        removeAction(forKey: "drop")
        run(SKAction.scale(to: 1.3, duration: 0.25), withKey: "pickup")
    }
    
    func dropAnimation() {
        
        removeAction(forKey: "pickup")
        run(SKAction.scale(to: 1.0, duration: 0.25))
    }
    
    func startRotationAnimation() {
        
        let rotateRight = SKAction.rotate(byAngle: 0.15, duration: 0.2)
        let rotateLeft = SKAction.rotate(byAngle: -0.15, duration: 0.2)
        let rotate = SKAction.sequence([rotateRight, rotateLeft, rotateLeft, rotateRight])
        
        run(SKAction.repeatForever(rotate), withKey: "rotation")
    }
    
    func stopRotationAnimation() {
        
        removeAction(forKey: "rotation")
        run(SKAction.rotate(toAngle: 0, duration: 0.2))
    }
    
    public func flipAnimation(delay: TimeInterval = 0) {
        
        let firstHalfFlip = SKAction.scaleX(to: 0, duration: 0.2)
        let secondHalfFlip = SKAction.scaleX(to: 1, duration: 0.2)
        
        setScale(1.0)
        
        let flipTexture = isFaceUp ? Card.back : front
        
        let wait = SKAction.wait(forDuration: delay)

        run(SKAction.sequence([wait, firstHalfFlip])) {
            self.texture = flipTexture
            self.run(secondHalfFlip)
            self.flip()
        }
        
    }
}

extension Array where Element: Card {
    
    func pickUpAnimation() {
        forEach { $0.pickUpAnimation() }
    }
    func dropAnimation() {
        forEach { $0.dropAnimation() }
    }
    func startRotationAnimation() {
        forEach { $0.startRotationAnimation() }
    }
    func stopRotationAnimation() {
        forEach { $0.stopRotationAnimation() }
    }
    
    func flipAnimation(delay: TimeInterval) {
        for (i, card) in reversed().enumerated() {
            card.flipAnimation(delay: delay * Double(i) * 0.4)
        }
    }
}

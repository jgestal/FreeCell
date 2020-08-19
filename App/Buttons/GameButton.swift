//
//  GameButton.swift
//  Solitaire
//
//  Created by Juan on 13/08/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import SpriteKit

enum GameButtonState {
    case normal,pressed
}

class GameButton: SKSpriteNode {
    
    let normalStateTexture : SKTexture!
    let pressedStateTexture : SKTexture!
    
    let pressedSFX = SKAction.playSoundFileNamed("selectButton", waitForCompletion: false)
    
    let action: () -> ()?
    
    var state : GameButtonState = .normal {
        didSet {
            switch state {
            case .normal:
                texture = normalStateTexture
            case .pressed:
                texture = pressedStateTexture
            }
        }
    }
    
    init(name: String, action: @escaping () -> ()) {
        
        normalStateTexture = SKTexture.init(imageNamed: "\(name)Button")
        pressedStateTexture = SKTexture.init(imageNamed: "\(name)ButtonPressed")
        
        self.action = action
        
        super.init(texture: self.normalStateTexture, color: .clear, size: normalStateTexture.size())
        
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapped() {
        if state == .normal {
            state = .pressed
            run(pressedSFX)
            
            let waitAction = SKAction.wait(forDuration: 0.3)
            let performAction = SKAction.run { self.action () }
            let returnToNormalState = SKAction.run { self.state = .normal }
            
            self.run(SKAction.sequence([waitAction, returnToNormalState, performAction]))
        }
    }
}

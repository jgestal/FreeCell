//
//  DIScene.swift
//  Solitaire
//
//  Created by Juan on 10/06/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import SpriteKit


class DIScene: SKScene {
        
    func startDrag(at location: CGPoint) { }
    
    func dragMoved(to location: CGPoint) { }
    
    func endDrag(at location: CGPoint) { }
    
    func doubleTap(at location: CGPoint) { }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        
        if (touch.tapCount > 1) {
            doubleTap(at: location)
        } else {
            if let button = self.nodes(at: location).first as? GameButton {
                button.tapped()
            }
            else {
                startDrag(at: location)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        dragMoved(to: touch.location(in: self))
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        endDrag(at: touch.location(in: self))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        endDrag(at: touch.location(in: self))
    }
}

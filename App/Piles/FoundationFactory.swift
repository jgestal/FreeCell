//
//  FoundationFactory.swift
//  Solitaire
//
//  Created by Juan on 12/08/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import SpriteKit

class FoundationFactory {
    
    static func create(at position: CGPoint) -> InteractivePile {
             
             let acceptRules : [AcceptRule] = [AcceptRule_SourceIsAnAceAndTargetIsEmpty(),AcceptRule_SourceCardIsNextRankOfSameSuit()]
             let takeRules : [TakeRule] = [TakeRule_CanTakeLastCard()]
             
             return InteractivePile(offset: CGSize(width: 0, height: 0),
                                    position: position,
                                    acceptRules: acceptRules,
                                    takeRules: takeRules,
                                    texture: SKTexture.init(imageNamed: "foundation"))
    }
}

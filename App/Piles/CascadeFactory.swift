//
//  CascadeFactory.swift
//  Solitaire
//
//  Created by Juan on 12/08/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import SpriteKit

class CascadeFactory {
    
    static func create(at position: CGPoint) -> InteractivePile {
             
             let acceptRules : [AcceptRule] = [AcceptRule_SourceLastCardIsOppositeColorAndPreviousRank(), AcceptRule_AceptAllCardsIfTargetIsEmpty()]
             let takeRules : [TakeRule] = [TakeRule_TakeIfNextCardsAreDescentCardsFromOppositeColors()]
             
             
             return InteractivePile(offset: CGSize(width: 0, height: -30),
                                     position: position,
                                     acceptRules: acceptRules,
                                     takeRules: takeRules,
                                     texture: SKTexture.init(imageNamed: "cascade"))
    }
}

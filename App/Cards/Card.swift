//
//  Card.swift
//  Solitaire
//
//  Created by Juan on 08/06/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import SpriteKit

final class Card: SKSpriteNode {
    
    static let back = SKTexture.init(imageNamed: "back")
    
    private(set) var rank: Rank
    private(set) var suit: Suit
    
    private(set) var isFaceUp = false
        
    var pile : Pile?
    
    private(set) var front : SKTexture!
    
    override var description: String {
        "\(rank.rawValue)\(suit.rawValue)"
    }

    init(rank: Rank, suit: Suit) {
        
        self.rank = rank
        self.suit = suit

        super.init(texture: Card.back, color: .clear, size: CGSize(width: Card.back.size().width / 9, height: Card.back.size().height / 9))
    
        front = SKTexture.init(imageNamed: description)        
    }
    public func flip() {
        isFaceUp = !isFaceUp
        //texture = isFaceUp ? front : Card.back
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


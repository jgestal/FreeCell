//
//  Dealer.swift
//  Solitaire
//
//  Created by Juan on 14/08/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import Foundation

class Dealer {

    static func deal(seed: Int, cascades: [InteractivePile]) {
        
        let deck = FreecellGameGenerator.getDeck(seed: seed)
         
         var i = 0
         
         while(!deck.isEmpty()) {
             
             let card = deck.getCard()!
             
             let cascade = cascades[i%cascades.count]
             cascade.add(cards: [card])
             
             i += 1
         }
     }
}

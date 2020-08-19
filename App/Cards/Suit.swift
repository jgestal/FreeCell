//
//  Suit.swift
//  Solitaire
//
//  Created by Juan on 09/06/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import Foundation

enum SuitColor {
    case red, black
}

enum Suit: String, CaseIterable {
    
    case clubs    = "C"  // ♣️
    case diamonds = "D"  // ♦️
    case hearts   = "H"  // ♥️
    case spades   = "S"  // ♠️
    
    var color : SuitColor {
        return self == .hearts || self == .diamonds ? .red : .black
    }
}

//
//  AcceptRule.swift
//  Solitaire
//
//  Created by Juan on 12/08/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import Foundation


protocol AcceptRule {
    func comply(source: [Card], target: [Card]) -> Bool
}

final class AcceptRule_AceptAllCardsIfTargetIsEmpty: AcceptRule {
   
    func comply(source: [Card], target: [Card]) -> Bool {
        return target.isEmpty
    }
}

final class AcceptRule_SourceLastCardIsOppositeColorAndPreviousRank: AcceptRule {
    
    func comply(source: [Card], target: [Card]) -> Bool {
        source.first != nil &&
        target.last != nil &&
        source.first!.suit.color != target.last!.suit.color &&
        source.first!.rank.rawValue == target.last!.rank.rawValue - 1
    }
}

final class AcceptRule_SourceIsAnAceAndTargetIsEmpty: AcceptRule {
    
    func comply(source: [Card], target: [Card]) -> Bool {
        source.first != nil &&
        source.first!.rank == .ace &&
        source.count == 1 &&
        target.isEmpty
    }
}

final class AcceptRule_SourceCardIsNextRankOfSameSuit: AcceptRule {
    
    func comply(source: [Card], target: [Card]) -> Bool {
        source.last != nil &&
        target.last != nil &&
        source.count == 1 &&
        source.last!.suit == target.last!.suit &&
        source.last!.rank.rawValue == target.last!.rank.rawValue + 1
    }
}

final class AcceptRule_OnlyOneCard: AcceptRule {
    
    func comply(source: [Card], target: [Card]) -> Bool {
        source.count == 1 &&
        target.count == 0
    }
}

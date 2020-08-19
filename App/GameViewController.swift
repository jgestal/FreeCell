//
//  GameViewController.swift
//  Solitaire
//
//  Created by Juan on 08/06/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

// Game Aspect Ratio:
// https://code.bitbebop.com/spritekit-game-aspect-ratio-resolution/

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        guard let view = view as? SKView else { fatalError("No SKView") }
                
        let scene = MenuScene(size: GameConfig.size)
        scene.scaleMode = .aspectFit
        view.presentScene(scene)
    }
}

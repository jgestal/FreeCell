//
//  MenuScene.swift
//  Solitaire
//
//  Created by Juan on 14/08/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import SpriteKit

class MenuScene: DIScene {
    
    override func didMove(to view: SKView) {
        
        setupBackgroundColor()
        setupTitle()
        setupButtons()
    }
    
    private func setupBackgroundColor() {
        backgroundColor = UIColor(red: 0.02, green: 0.53, blue: 0.31, alpha: 1.00)
    }
    
    private func setupTitle() {
        
        let texture = SKTexture.init(imageNamed: "title")
        let title = SKSpriteNode.init(texture: texture)
        title.position = CGPoint(x: size.width / 2, y: size.height / 2 + 200)
        addChild(title)
    }
    
    private func setupButtons() {
        
        let newGameButton = GameButton.init(name: "newGame") {
            self.newGame()
        }
        addChild(newGameButton)
        newGameButton.position = CGPoint(x: size.width / 2, y: size.height / 2 - 100)
        
        let selectGameButton = GameButton.init(name: "selectGame") {
            self.selectGameButtonTapped()
        }
        addChild(selectGameButton)
        selectGameButton.position = CGPoint(x: size.width / 2, y: size.height / 2 - 240)
    }
    
    private func newGame(seed: Int? = nil) {
        let gameScene = GameScene(size: GameConfig.size)
        gameScene.scaleMode = .aspectFit
        gameScene.seed = seed
        view?.presentScene(gameScene)
    }
    
    private func selectGameButtonTapped() {
        selectGame()
    }
    
    private func selectGame(title: String = "Select game") {
        
        let alertController = UIAlertController.init(title: title, message: "You can select a game from 1 to 32.000", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.keyboardType = .numberPad
        }
        
        alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (UIAlertAction) in
            
            guard
                let textField = alertController.textFields?[0],
                let seed = Int(textField.text ?? "0"),
                1...32000 ~= seed
            else {
                    self.selectGame(title: "Invalid selection")
                    return
            }
            
            self.newGame(seed: seed)
        }))
        
        alertController.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

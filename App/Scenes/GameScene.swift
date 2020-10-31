//
//  GameScene.swift
//  Solitaire
//
//  Created by Juan on 08/06/2020.
//  Copyright © 2020 Pixfans. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: DIScene {
    
    var seed : Int?
    
    let NUMBER_OF_CASCADES      = 8
    let NUMBER_OF_FOUNDATIONS   = 4
    let NUMBER_OF_OPEN_CELLS    = 4
    
    var cascades    = [InteractivePile]()
    var foundations = [InteractivePile]()
    var openCells   = [InteractivePile]()
    
    var currentMove : Move?
    
    var undoMoveButton : GameButton!
    var gameOverMessage: SKSpriteNode!
    
    var moves = [Move]() {
        didSet {
            
            if let last = moves.last, last.origin == last.destination {
                moves.removeLast()
                return
            }
            
            movesCounter += 1
            
            if (isEndOfGame) {
                gameOver()
            }
        }
    }
    
    var isEndOfGame: Bool {
        return foundations.reduce(true, { $0 && $1.cards.count == 13 })
    }
    
    var movesCounter = 0 {
        didSet {
            updateInfoLabel()
        }
    }
    
    var infoLabel: SKLabelNode!
    var guy: SKSpriteNode!
    
    let gameStartSFX = SKAction.playSoundFileNamed("gameStart", waitForCompletion: false)
    let cardPlaceSFX = SKAction.playSoundFileNamed("cardPlace", waitForCompletion: false)
    let gameOverSFX = SKAction.playSoundFileNamed("gameOver", waitForCompletion: false)
    
    
    override func didMove(to view: SKView) {
        seed = seed ?? Int.random(in: 1...32000)
        
        setupBackgroundColor()
        setupPiles()
        setupButtons()
        setupInfoLabel()
        setupGameOverMessage()
        
        setupGuy()
        dealCards(seed: seed!)
        
    }
    
    // MARK: Setup UI
    
    private func setupBackgroundColor() {
        
        backgroundColor = UIColor(red: 0.02, green: 0.53, blue: 0.31, alpha: 1.00)
    }
    
    private func setupPiles() {
        
        setupFoundations()
        setupOpenCells()
        setupCascades()
    }
    
    private func setupFoundations() {
        
        for i in 0..<NUMBER_OF_FOUNDATIONS {
            
            let foundation = FoundationFactory.create(at: CGPoint(x: 100 + 125 * (i + 4), y: Int(size.height) - 80))
            addChild(foundation)
            foundations.append(foundation)
        }
    }
    
    private func setupOpenCells() {
        
        for i in 0..<NUMBER_OF_OPEN_CELLS {
            
            let stack = OpenCellFactory.create(at: CGPoint(x: 50 + 125 * i, y:  Int(size.height) - 80))
            addChild(stack)
            openCells.append(stack)
        }
    }
    
    private func setupCascades() {
        
        for i in 0..<NUMBER_OF_CASCADES {
            
            let stack = CascadeFactory.create(at: CGPoint(x: 75 + 125 * i, y: Int(size.height) - 210))
            stack.updateCards()
            addChild(stack)
            cascades.append(stack)
        }
    }
    
    private func setupInfoLabel() {
        
        infoLabel = SKLabelNode.init()
        infoLabel.fontSize = 14
        infoLabel.horizontalAlignmentMode = .left
        infoLabel.fontName = "Helvetica"
        infoLabel.position = CGPoint(x: 10, y: 10)
        addChild(infoLabel)
        updateInfoLabel()
    }
    
    private func updateInfoLabel() {
        infoLabel.text = "Game: \(seed!), Moves: \(movesCounter)"
    }
    
    private func setupButtons() {
        
        undoMoveButton = GameButton.init(name: "undoMove") {
            self.undoMove()
        }
        addChild(undoMoveButton)
        undoMoveButton.position = CGPoint(x: size.width / 2 - 40, y: 20)
        
        let restartButton = GameButton.init(name: "restart") {
            self.restartGameAlert()
        }
        addChild(restartButton)
        restartButton.position = CGPoint(x: size.width / 2, y: 20)
        
        let exitButton = GameButton.init(name: "exit") {
            self.exitGameAlert()
        }
        addChild(exitButton)
        exitButton.position = CGPoint(x: size.width / 2 + 40, y: 20)
    }
    
    private func setupGuy() {
        let texture = SKTexture.init(imageNamed: "jimmy")
        texture.filteringMode = .nearest
        guy = SKSpriteNode.init(texture: texture)
        guy.position = CGPoint(x: size.width / 2, y: size.height - 80)
        addChild(guy)
    }
    
    private func guyLook(at point: CGPoint) {
        guy.xScale = point.x > size.width / 2 ? -1 : 1
    }
    
    
    private func setupGameOverMessage() {
        let texture = SKTexture.init(imageNamed: "gameOver")
        gameOverMessage = SKSpriteNode.init(texture: texture)
        gameOverMessage.position = CGPoint(x: size.width / 2, y: 100)
        gameOverMessage.scale(to: CGSize(width: 0, height: 0))
        gameOverMessage.zPosition = 9999
        addChild(gameOverMessage)
    }
    
    private func animateGameOverMessage() {
        
        run(gameOverSFX)
        let move = SKAction.move(to: CGPoint(x: size.width / 2, y: size.height / 2 + 90), duration: 0.5)
        move.timingMode = .easeInEaseOut
        let scale = SKAction.scale(to: 1.0, duration: 0.5)
        let group = SKAction.group([move,scale])
        gameOverMessage.run(group)
    }
    
    private func dealCards(seed: Int) {
        
        Dealer.deal(seed: seed, cascades: cascades)
        
        cascades.forEach {
            $0.cards.forEach { addChild($0) }
            $0.updateCards()
            
            $0.cards.flipAnimation(delay: 0.2)
        }
        
        run(gameStartSFX)
    }
    
    private func gameOver() {
        
        animateGameOverMessage()
        
        let wait = SKAction.wait(forDuration: 2.0)
        let exitGame = SKAction.run {
            self.exitGame()
        }
        run(SKAction.sequence([wait,exitGame]))
    }
    
    private func undoMove() {
        
        guard let lastMove = moves.last else { return }
        
        lastMove.revert()
        lastMove.destination?.updateCards()
        lastMove.origin.updateCards(animated: true)
        
        moves.removeLast()
    }
    
    private func restartGameAlert() {
        
        let alertController = UIAlertController.init(title: "Restart game?", message: "You will loose your current progress", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (UIAlertAction) in
            self.restartGame()
        }))
        
        alertController.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    private func exitGameAlert() {
        
        let alertController = UIAlertController.init(title: "Return to main screen?", message: "You will loose your current progress", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (UIAlertAction) in
            self.exitGame()
        }))
        
        alertController.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    private func restartGame() {
        let gameScene = GameScene(size: GameConfig.size)
        gameScene.seed = self.seed
        gameScene.scaleMode = .aspectFit
        self.view?.presentScene(gameScene)
    }
    
    private func exitGame() {
        let menuScene = MenuScene(size: GameConfig.size)
        menuScene.scaleMode = .aspectFit
        self.view?.presentScene(menuScene)
    }
    
    private func getInteractivePile(nodes: [SKNode]) -> InteractivePile? {
        
        for node in nodes {
            if let card = node as? Card,
                let pile = card.pile as? InteractivePile {
                return pile
            }
            else if let pile = node as? InteractivePile {
                return pile
            }
        }
        return nil
    }
    
    //MARK: Interaction
    
    override func doubleTap(at location: CGPoint) {
        
        guard
            let card = self.nodes(at: location).first as? Card,
            let pile = card.pile as? InteractivePile,
            let move = pile.moveFrom(card: card)
            else { return }
        
        for pile in foundations + openCells {
            if pile.canAccept(cards: move.cards) {
                makeMove(move: move, to: pile)
                return
            }
        }
        move.cancel()
    }
    
    override func startDrag(at location: CGPoint) {
        
        guard
            let card = self.nodes(at: location).first as? Card,
            let pile = card.pile as? InteractivePile,
            let move = pile.moveFrom(card: card)
            else { return }
        
        move.position = location
        move.updateCards()
        
        move.cards.pickUpAnimation()
        move.cards.startRotationAnimation()
        
        run(cardPlaceSFX)
        
        currentMove = move
    }
    
    override func dragMoved(to location: CGPoint) {
        
        guard let move = currentMove else { return }
        
        guyLook(at: location)
        
        move.position = location
        move.updateCards()
    }
    
    override func endDrag(at location: CGPoint) {
        
        guard let move = currentMove else { return }
        currentMove = nil
        
        let nodes = self.nodes(at: location)
        
        move.cards.dropAnimation()
        move.cards.stopRotationAnimation()
        
        guard
            let target = getInteractivePile(nodes: nodes),
            target != move.origin,
            target.canAccept(cards: move.cards)
            else {
                move.cancel()
                return
        }
        makeMove(move: move, to: target)
    }
    
    private func makeMove(move: Move, to interactivePile: InteractivePile) {
        move.moveCards(destination: interactivePile)
        moves.append(move)
        run(cardPlaceSFX)
    }
}


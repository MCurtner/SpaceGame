//
//  GameScene.swift
//  SpaceGame
//
//  Created by Matthew Curtner on 10/18/15.
//  Copyright (c) 2015 Matthew Curtner. All rights reserved.
//

import SpriteKit

enum Layers: CGFloat {
    case Stars
    case FarPlanets
    case NearPlanets
    case Fire
    case StarShip
}

class GameScene: SKScene {
    
    // SKSpriteNodes
    let starShip = SKSpriteNode(imageNamed: "Ship")
    let enemyShip = SKSpriteNode(imageNamed: "EnemyShip")
    
    // Offset of Y-Postion of players touch
    let kShipTouchHeightOffset: CGFloat = 120.0
    
    // Timer for firing weapon in intervals
    var timer = NSTimer()
    var enemyTimer = NSTimer()
    
    // Laser sound action
    let sound = SKAction.playSoundFileNamed("laser.mp3", waitForCompletion: false)
    
    // BackgroundElements Instance
    let bgElement = BackgroundElements()

    
    
    // MARK: - Scene Lifecycle
    
    override func didMoveToView(view: SKView) {
        
        // Add Background Elements
        addChild(bgElement.setupBackground(self.frame.size.width, frameHeight: self.frame.size.height))
        addChild(bgElement.setupStars())
        addChild(bgElement.setupStars2())
        
        addChild(bgElement.setupFarPlanets())
        addChild(bgElement.setupFarPlanets2())
        addChild(bgElement.setupPlanets())
        
        // Add the Ship
        setupShip()
        spawnEnemy()
        
        // Start the Background Music
        playBackgroundMusic()
    }
    
    
    // MARK: - Touches Methods
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            starShip.position.x = location.x
            
            // Not allowing the ship to pass a certain height
            if location.y < self.frame.size.height/5 {
                starShip.position.y = location.y
                starShip.position.y += kShipTouchHeightOffset
            }
            
            // Firing Weapon when user touches
            shootWeapon()
            enemyFire()
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            starShip.position.x = location.x
            
            // Not allowing the ship to pass a certain height
            if location.y < self.frame.size.height/5 {
                starShip.position.y = location.y
                starShip.position.y += kShipTouchHeightOffset
            }
        }
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Invalidate the timer to stop the weapon from firing
        timer.invalidate()
        enemyTimer.invalidate()
    }
    

    // MARK: - Update Loop
    
    override func update(currentTime: CFTimeInterval) {
        
        // Move the background elements down
        bgElement.moveStarsDown()
        bgElement.moveFarPlanetsDown()
        bgElement.movePlanetsDown()
    }
    
    
    // MARK: - Background Music
    
    func playBackgroundMusic() {
        let bgMusic = SKAction.playSoundFileNamed("bgMusic.wav", waitForCompletion: true)
        let playBGMusic = SKAction.repeatActionForever(bgMusic)
        
        runAction(playBGMusic)
    }
    
    
    
    // MARK: - Ship Methods
    
    func setupShip() {
        starShip.size = CGSize(width: 100, height: 150)
        starShip.zPosition = Layers.StarShip.rawValue
        starShip.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/5)
        starShip.name = "ship"
        addChild(starShip)
    }
    
    func spawnFire() {
        let fire = SKSpriteNode(imageNamed: "Fire")
        fire.size = CGSizeMake(100, 150)
        fire.zPosition = Layers.Fire.rawValue
        fire.position = CGPointMake(starShip.position.x, starShip.position.y)
        let action = SKAction.moveToY(frame.size.height * 3, duration: 1.0)

        fire.runAction(SKAction.repeatActionForever(action))
        fire.runAction(sound)
        self.addChild(fire)
    }
    
    func shootWeapon() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("spawnFire"), userInfo: nil, repeats: true)
        
        //pulsateBackground()
        shakeScreen()
    }
    
    
    // MARK: - Enemy Methods
    
    func spawnEnemy() {
        enemyShip.size = CGSize(width: 100, height: 150)
        enemyShip.zPosition = Layers.StarShip.rawValue
        enemyShip.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        enemyShip.name = "enemy"
        addChild(enemyShip)
    }
    
    func spawnEnemyFire() {
        let fire = SKSpriteNode(imageNamed: "Fire")
        fire.size = CGSizeMake(100, 150)
        fire.zPosition = Layers.Fire.rawValue
        fire.position = CGPointMake(enemyShip.position.x, enemyShip.position.y)
        let action = SKAction.moveToY(-frame.size.height * 3, duration: 1.0)
        
        fire.runAction(SKAction.repeatActionForever(action))
        fire.runAction(sound)
        self.addChild(fire)
    }
    
    func enemyFire() {
        enemyTimer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("spawnEnemyFire"), userInfo: nil, repeats: true)
    }
    

    // MARK: - Effects
    
    // Quickly enlarge and then set back the scale of the sprites
    func pulsateBackground() {
        
        self.childNodeWithName("background")?.runAction(SKAction.scaleTo(1.05, duration: 0.05), completion: { () -> Void in
            self.childNodeWithName("background")?.runAction(SKAction.scaleTo(1.0, duration: 0.05))
        })
        self.childNodeWithName("planet")?.runAction(SKAction.scaleTo(1.05, duration: 0.05), completion: { () -> Void in
            self.childNodeWithName("planet")?.runAction(SKAction.scaleTo(1.0, duration: 0.05))
        })
        self.childNodeWithName("ship")?.runAction(SKAction.scaleTo(1.05, duration: 0.05), completion: { () -> Void in
            self.childNodeWithName("ship")?.runAction(SKAction.scaleTo(1.0, duration: 0.05))
        })
    }
    
    // Shake the screen when hit
    func shakeScreen() {
        let moveX_1: SKAction = SKAction.moveBy(CGVectorMake(-50, 0), duration: 0.05)
        let moveX_2: SKAction = SKAction.moveBy(CGVectorMake(-50, 0), duration: 0.05)
        let moveX_3: SKAction = SKAction.moveBy(CGVectorMake(50, 0), duration: 0.05)
        let moveX_4: SKAction = SKAction.moveBy(CGVectorMake(50, 0), duration: 0.05)
        
        let moveY_1: SKAction = SKAction.moveBy(CGVectorMake(-0, -50), duration: 0.05)
        let moveY_2: SKAction = SKAction.moveBy(CGVectorMake(0, -50), duration: 0.05)
        let moveY_3: SKAction = SKAction.moveBy(CGVectorMake(0, 50), duration: 0.05)
        let moveY_4: SKAction = SKAction.moveBy(CGVectorMake(0, 50), duration: 0.05)
        
        let trembleX: SKAction = SKAction.sequence([moveX_1, moveX_4, moveX_2, moveX_3])
        let trembleY: SKAction = SKAction.sequence([moveY_1, moveY_4, moveY_2, moveY_3])

        for child in self.children {
            child.runAction(trembleX)
            child.runAction(trembleY)
        }
    }
    
}

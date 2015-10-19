//
//  GameScene.swift
//  SpaceGame
//
//  Created by Matthew Curtner on 10/18/15.
//  Copyright (c) 2015 Matthew Curtner. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let stars = SKSpriteNode(imageNamed: "stars")
    let stars2 = SKSpriteNode(imageNamed: "stars")
    let planet = SKSpriteNode(imageNamed: "planetBig")
    let farPlanets = SKSpriteNode(imageNamed: "farPlanets")
    let farPlanets2 = SKSpriteNode(imageNamed: "farPlanets")
    let planet2 = SKSpriteNode(imageNamed: "planetRing")
    let starShip = SKSpriteNode(imageNamed: "Ship")
    
    
    override func didMoveToView(view: SKView) {

        // Add Background
        setupBackground()
       
        // Add Stars and Far Planets
        setupOverlays(stars, sprite2: stars2, zPos: 0)
        setupOverlays(farPlanets, sprite2: farPlanets2, zPos: 1)
        
        // Add Planets
        setupPlanets(planet)
        
        
        // Add Ship
        starShip.size = CGSize(width: 100, height: 150)
        starShip.zPosition = 3
        starShip.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/5)
        addChild(starShip)
        
        
        let Timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("spawnFire"), userInfo: nil, repeats: true)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            starShip.position.x = location.x
        }
    }
   
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            starShip.position.x = location.x
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {

        moveDown(stars, sprite2: stars2, speed: 0.5)
        moveDown(farPlanets, sprite2: farPlanets2, speed: 0.7)
        movePlanetsDown()
    }
    
    
    func spawnFire() {
        let fire = SKSpriteNode(imageNamed: "Fire")
        fire.size = CGSizeMake(100, 150)
        fire.zPosition = 2
        fire.position = CGPointMake(starShip.position.x, starShip.position.y)
        let action = SKAction.moveToY(stars.size.height + 30, duration: 1.0)
        fire.runAction(SKAction.repeatActionForever(action))
        self.addChild(fire)
    }
    
    
    
    // MARK: Setup Methods
    
    /*
        Setup and add the background to the scene
    */
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "Background")
        background.position = CGPointMake(self.size.width/2, self.size.height/2)
        background.zPosition = -1
        addChild(background)
    }
    
    
    /*
        Setup and add the two star overlays the scene. The second 
        ontop of the other in order to repeat.
    */
    func setupOverlays(sprite1: SKSpriteNode, sprite2: SKSpriteNode, zPos: CGFloat) {
        // Add overlay1
        sprite1.position = CGPointMake(self.size.width/2, self.size.height/2)
        sprite1.zPosition = zPos
        addChild(sprite1)
        
        // Add overlay2
        sprite2.position = CGPointMake(self.size.width/2, sprite1.size.height + 10)
        sprite2.zPosition = zPos
        addChild(sprite2)
    }
    
    
    /*
        Move the sprite images down at a rate of set speed downward for every
        1/60 of a second
    */
    func moveDown(sprite1: SKSpriteNode, sprite2: SKSpriteNode, speed: CGFloat) {
        sprite1.position = CGPoint(x: sprite1.position.x, y: sprite1.position.y - speed)
        sprite2.position = CGPoint(x: sprite2.position.x, y: sprite2.position.y - speed)
        
        /*
        Place the sprite1 overlay at the top of sprite2 image
        once it's position is less than the -height of iteself
        */
        if sprite1.position.y < -sprite1.size.height {
            sprite1.position.y = sprite2.size.height + 10
        }
        if sprite2.position.y < -sprite2.size.height {
            sprite2.position.y = sprite1.size.height + 10
        }

    }
    
    /*
        Setup the planet CGSize to be a radom number between
        1 and 899
    */
    func radomizePlanetSize() -> CGSize {
        let randomNumber = Int(arc4random_uniform(900))
        return CGSize(width: randomNumber, height: randomNumber)
    }
    
    
    /*
        Randomly place the planet image using the screensize 
        width and hieght as parameters
    */
    func randomPlanetPosition(screenWidth: UInt32, screenHeight: UInt32) -> CGPoint {
        let randomX = CGFloat(arc4random_uniform(screenWidth))
        let randomY = CGFloat(arc4random_uniform(screenHeight))
        return CGPointMake(randomX, randomY)
    }
    
    /*
        Setup and add the planet to the scene
    */
    func setupPlanets(planet: SKSpriteNode) {
        planet.zPosition = 2
        planet.size = radomizePlanetSize()
        planet.position = randomPlanetPosition(UInt32(self.frame.size.width), screenHeight: UInt32(self.frame.size.height) * 2)
        addChild(planet)
    }
    
    /*
        Move the planet images down at a rate of 5 downward for every
        1/60 of a second
    */
    func movePlanetsDown() {
        planet.position = CGPoint(x: planet.position.x, y: planet.position.y - 3)
        planet2.position = CGPoint(x: planet2.position.x, y: planet2.position.y - 3)
        
        /*
        If the planet image position.y is less than
        stars overlay height, remove it from the parent
        and create a new planet at the top of the screen
        */
        if planet.position.y < -stars.size.height {
            planet.removeFromParent()
            
            setupPlanets(planet)
            
            planet.position.y = stars.size.height + 10
        }
    }

    
}

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
    let planet2 = SKSpriteNode(imageNamed: "planetRing")
    let starShip = SKSpriteNode(imageNamed: "Spaceship")
    
    override func didMoveToView(view: SKView) {

        // Add Background
        setupBackground()
       
        // Add Stars
        setupStars()
        
        // Add Planet
        setupPlanets(planet)
        setupPlanets(planet2)
        
        // Add Ship
        starShip.size = CGSize(width: 100, height: 100)
        starShip.zPosition = 3
        starShip.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/3)
        addChild(starShip)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {

        stars.position = CGPoint(x: stars.position.x, y: stars.position.y - 1)
        stars2.position = CGPoint(x: stars2.position.x, y: stars2.position.y - 1)

        planet.position = CGPoint(x: planet.position.x, y: planet.position.y - 5)
        planet2.position = CGPoint(x: planet2.position.x, y: planet2.position.y - 5)
        
        if stars.position.y < -stars.size.height {
            stars.position.y = stars2.size.height + 10
        }
        if stars2.position.y < -stars2.size.height {
            stars2.position.y = stars.size.height + 10
        }
        
    }
    
    // MARK: Setup Methods
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "Background")
        background.position = CGPointMake(self.size.width/2, self.size.height/2)
        background.zPosition = -1
        addChild(background)
    }
 
    func setupStars() {
        // Add Stars
        stars.position = CGPointMake(self.size.width/2, self.size.height/2)
        stars.zPosition = 0
        addChild(stars)
        
        stars2.position = CGPointMake(self.size.width/2, stars.size.height + 10)
        stars2.zPosition = 0
        addChild(stars2)
    }
    
    func radomizePlanetSize() -> CGSize {
        let randomNumber = Int(arc4random_uniform(500))
        return CGSize(width: randomNumber, height: randomNumber)
    }
    
    func randomPlanetPosition(screenWidth: UInt32, screenHeight: UInt32) -> CGPoint {
        let randomX = CGFloat(arc4random_uniform(screenWidth))
        let randomY = CGFloat(arc4random_uniform(screenHeight))
        return CGPointMake(randomX, randomY)
    }
    
    func setupPlanets(planet: SKSpriteNode) {
        planet.zPosition = 1
        planet.size = radomizePlanetSize()
        planet.position = randomPlanetPosition(UInt32(self.frame.size.width), screenHeight: UInt32(self.frame.size.height + 21))
        addChild(planet)
    }
    
    
}

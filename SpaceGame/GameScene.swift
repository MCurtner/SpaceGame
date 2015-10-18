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
        
        // Add Planets
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

        moveStarDown()
        movePlanetsDown()
        
        
        /*
            Place the stars overlay at the top of stars2 image
            once it's position is less than the -height of iteself
        */
        if stars.position.y < -stars.size.height {
            stars.position.y = stars2.size.height + 10
        }
        if stars2.position.y < -stars2.size.height {
            stars2.position.y = stars.size.height + 10
        }
        
        
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
    func setupStars() {
        // Add Stars
        stars.position = CGPointMake(self.size.width/2, self.size.height/2)
        stars.zPosition = 0
        addChild(stars)
        
        stars2.position = CGPointMake(self.size.width/2, stars.size.height + 10)
        stars2.zPosition = 0
        addChild(stars2)
    }
    
    
    /*
        Move the stars overlay down at a rate of 1 downward for ever 1/60
        of a second
    */
    func moveStarDown() {
        stars.position = CGPoint(x: stars.position.x, y: stars.position.y - 1)
        stars2.position = CGPoint(x: stars2.position.x, y: stars2.position.y - 1)
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
        planet.zPosition = 1
        planet.size = radomizePlanetSize()
        planet.position = randomPlanetPosition(UInt32(self.frame.size.width), screenHeight: UInt32(self.frame.size.height) * 2)
        addChild(planet)
    }
    
    /*
        Move the planet images down at a rate of 5 downward for every
        1/60 of a second
    */
    func movePlanetsDown() {
        planet.position = CGPoint(x: planet.position.x, y: planet.position.y - 5)
        planet2.position = CGPoint(x: planet2.position.x, y: planet2.position.y - 5)
    }
    
}

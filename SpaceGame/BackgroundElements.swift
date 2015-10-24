//
//  BackgroundElements.swift
//  SpaceGame
//
//  Created by Matthew Curtner on 10/21/15.
//  Copyright © 2015 Matthew Curtner. All rights reserved.
//

import SpriteKit

class BackgroundElements: SKNode {
    
    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    // Sprite Images
    let stars = SKSpriteNode(imageNamed: "stars")
    let stars2 = SKSpriteNode(imageNamed: "stars")
    let planet = SKSpriteNode(imageNamed: "planetBig")
    let farPlanets = SKSpriteNode(imageNamed: "farPlanets")
    let farPlanets2 = SKSpriteNode(imageNamed: "farPlanets")
    let planet2 = SKSpriteNode(imageNamed: "planetRing")
    
    
    // MARK: - Setup Sprite Methods
    
    // Setup and return the background to the scene
    
    internal func setupBackground(frameWidth: CGFloat, frameHeight: CGFloat) -> SKSpriteNode {
        screenWidth = frameWidth
        screenHeight = frameHeight
        
        let background = SKSpriteNode(imageNamed: "Background")
        background.position = CGPointMake(frameWidth/2, frameHeight/2)
        background.zPosition = -1
        background.name = "background"
        
        return background
    }
    
    // Setup and return the stars overlay to the scene
    
    internal func setupStars() -> SKSpriteNode {
        // Add overlay1
        stars.position = CGPointMake(screenWidth!/2, stars.size.height/2)
        stars.zPosition = Layers.Stars.rawValue
        
        return stars
    }
    
    internal func setupStars2() -> SKSpriteNode {
        // Add overlay2
        stars2.position = CGPointMake(screenWidth!/2, stars.size.height * 2)
        stars2.zPosition = Layers.Stars.rawValue
        
        return stars2
    }

    
    // Setup and return the FarPlanets overlay to the scene

    internal func setupFarPlanets() -> SKSpriteNode {
        // Add overlay1
        farPlanets.position = CGPointMake(screenWidth!/2, farPlanets.size.height/2)
        farPlanets.zPosition = Layers.FarPlanets.rawValue
        
        return farPlanets
    }
    
    internal func setupFarPlanets2() -> SKSpriteNode {
        // Add overlay2
        farPlanets2.position = CGPointMake(screenWidth!/2, farPlanets2.size.height * 2)
        farPlanets2.zPosition = Layers.FarPlanets.rawValue
        
        return farPlanets2
    }
    
    
    // Setup and return the near planet sprite to the scene
    internal func setupPlanets() -> SKSpriteNode {
        planet.zPosition = Layers.NearPlanets.rawValue
        planet.size = radomizePlanetSize()
        planet.position = randomPlanetPosition(UInt32(screenWidth!), screenHeight: UInt32(screenHeight!) * 2)
        planet.name = "planet"
        return planet
    }
    
    
    // MARK: - Move Sprite Methods
    
    // Move the Star Overlays with a speed of 0.5
    
    internal func moveStarsDown() {
        moveDown(sprite1: stars, sprite2: stars2, speed: 0.5)
    }
    
    // Move the FarPlanets Overlays with a speed of 0.7
    
    internal func moveFarPlanetsDown() {
        moveDown(sprite1: farPlanets, sprite2: farPlanets2, speed: 0.7)
    }
    
    // Move the Near Planet Sprites with a speed of 3
    
    internal func movePlanetsDown() {
        planet.position = CGPoint(x: planet.position.x, y: planet.position.y - 3)
        planet2.position = CGPoint(x: planet2.position.x, y: planet2.position.y - 3)
        
        /*
        If the planet image position.y is less than
        stars overlay height, remove it from the parent
        and create a new planet at the top of the screen
        */
        if planet.position.y < -stars.size.height {
            planet.removeFromParent()
            
            setupPlanets()
            
            planet.position.y = stars.size.height + 10
        }
    }
    

    // MARK: - Private Helper Methods
    
    /*
        Move the sprite images down at a rate of set speed downward for every
        1/60 of a second
    */
    private func moveDown(sprite1 sprite1: SKSpriteNode, sprite2: SKSpriteNode, speed: CGFloat) {
        sprite1.position = CGPoint(x: sprite1.position.x, y: sprite1.position.y - speed)
        sprite2.position = CGPoint(x: sprite2.position.x, y: sprite2.position.y - speed)
        
        /*
        Place the sprite1 overlay at the top of sprite2 image
        once it's position is less than the -height of iteself
        */
        if sprite1.position.y < -sprite1.size.height {
            sprite1.position.y = sprite2.size.height + 100
        }
        if sprite2.position.y < -sprite2.size.height {
            sprite2.position.y = sprite1.size.height + 100
        }
        
    }
    
    /*
        Setup the planet CGSize to be a radom number between
        1 and 899
    */
    private func radomizePlanetSize() -> CGSize {
        let randomNumber = Int(arc4random_uniform(900))
        return CGSize(width: randomNumber, height: randomNumber)
    }
    
    /*
        Randomly place the planet image using the screensize
        width and hieght as parameters
    */
    private func randomPlanetPosition(screenWidth: UInt32, screenHeight: UInt32) -> CGPoint {
        let randomX = CGFloat(arc4random_uniform(screenWidth))
        let randomY = CGFloat(arc4random_uniform(screenHeight))
        return CGPointMake(randomX, randomY)
    }

    

    
}

//
//  Skater.swift
//  SchoolhouseSkateboard
//
//  Created by Teza on 2022/3/12.
//

import SpriteKit

class Skater: SKSpriteNode {
    var velocity = CGPoint.zero
    var minimumY: CGFloat = 0.0
    var jumpSpeed: CGFloat = 20.0
    var isOnGround = true
    
    func setupPhysicsBody() {
        if let skaterTexture = texture {
            physicsBody = SKPhysicsBody(texture: skaterTexture, size: size)
            
            physicsBody?.isDynamic = true
            physicsBody?.density = 6.0
            physicsBody?.allowsRotation = false
            physicsBody?.angularDamping = 1.0
            
            physicsBody?.categoryBitMask = PhysicsCategory.skater
            physicsBody?.collisionBitMask = PhysicsCategory.brick
            physicsBody?.contactTestBitMask = PhysicsCategory.brick | PhysicsCategory.gem
        }
    }
    
    func createSparks() {
        let bundle = Bundle.main
        
        if let sparksPath = bundle.path(forResource: "sparks", ofType: "sks") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: sparksPath)) {
                if let sparksNode = try? NSKeyedUnarchiver.unarchivedObject(ofClass: SKEmitterNode.self, from: data) {
                    sparksNode.position = CGPoint(x: 0.0, y: -50.0)
                    addChild(sparksNode)
                    
                    let waitAction = SKAction.wait(forDuration: 0.5)
                    let removeAction = SKAction.removeFromParent()
                    let waitThenRemove = SKAction.sequence([waitAction, removeAction])
                    
                    sparksNode.run(waitThenRemove)
                }
            }
        }
    }
}

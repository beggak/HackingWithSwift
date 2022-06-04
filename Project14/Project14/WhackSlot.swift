//
//  WhackSlot.swift
//  Project14
//
//  Created by begaiym akunova on 2/6/22.
//

import UIKit
import SpriteKit

class WhackSlot: SKNode {
    var charNode: SKSpriteNode!
    var smoke: SKEmitterNode!
    //var spark: SKEmitterNode!
    var isVisible = false
    var isHit = false
    
    func configure(at position: CGPoint) {
        self.position = position
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        
        addChild(cropNode)
    }
    
    func show(hideTime: Double) {
        if isVisible { return }
        charNode.xScale = 1
        charNode.yScale = 1
        
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        spark()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [weak self] in
            self?.hide()
        }
    }
    
    func hide() {
        if !isVisible { return }
        
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible = false
    }
    
    func spark() {
        if let spark = SKEmitterNode(fileNamed: "spark") {

            if isVisible {
                spark.position = CGPoint(x: 0, y: -10)
                spark.zPosition = 1.5
            }
            
            let spark = SKAction.sequence([
                SKAction.run { [weak self] in self?.addChild(spark) },
                SKAction.wait(forDuration: 0.3),
                SKAction.run { spark.removeFromParent() }
                ])
            
            run(spark)
        }
    }
    
    func hit() {
        isHit = true
        
        let delay = SKAction.wait(forDuration: 0.25)
        let hide = SKAction.moveBy(x: 0, y: -90, duration: 0.5)
        let notVisible = SKAction.run {[weak self] in self?.isVisible = false }
        smoke = SKEmitterNode(fileNamed: "smoke")
        smoke.position = charNode.position
        addChild(smoke)
        let stopSmoke = SKAction.run {[weak self] in self?.smoke.particleBirthRate = 0 }
        
        let sequence = SKAction.sequence([delay, stopSmoke, hide, notVisible])
        charNode.run(sequence)
    }

}

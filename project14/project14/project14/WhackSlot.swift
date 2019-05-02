//
//  WhackSlot.swift
//  project14
//
//  Created by Derek Stephen McLean on 02/05/2019.
//  Copyright © 2019 Derek Stephen McLean. All rights reserved.
//

import SpriteKit
import UIKit

class WhackSlot: SKNode {
    
    var charNode: SKSpriteNode!
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
        // if the penguin is aready visible, do nothing
        if isVisible { return }
        
        // move it 80px up over a time of 0.05
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        
        // set it as now visible
        isVisible = true
        // set at as not hit
        isHit = false
        
        // randomise a good or a bad penguin
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [weak self] in
            self?.hide()
        }
    }
    
    func hide() {
        
        // if already hidden do nothing
        if !isVisible { return }
        
        // move by 80 px over 0.05
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        
        // set hidden
        isVisible = false
    }
}

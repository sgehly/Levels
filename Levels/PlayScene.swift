//
//  PlayScene.swift
//  Levels
//
//  Created by Sam Gehly on 11/20/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import SnapKit

class PlayScene: SKScene, SKPhysicsContactDelegate {
    
    //Objects
    var level: Level? = nil
    var char: SKSpriteNode? = nil
    var xCharSpeed: CGFloat = 300
    var yCharSpeed: CGFloat = 400
    
    //Physics
    let Block:UInt32 = 1 << 0
    let Person:UInt32 = 1 << 1
    var xRate: CGFloat = 0.00
    var yRate: CGFloat = 0.00
    
    init(level: Level){
        super.init(size: UIScreen.mainScreen().bounds.size)
        self.level = level
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        
        let buttonD1 = 75
        let buttonD2 = 50
        
        let gamepad = UIImageView(image: UIImage(named: "gamepad"))
        gamepad.layer.opacity = 0.3
        self.view!.addSubview(gamepad)
        gamepad.snp_makeConstraints{ make in
            make.size.equalTo(200)
            make.bottom.equalTo(self.view!).offset(-10)
            make.left.equalTo(self.view!).offset(10)
        }
        
        let buttonLeft = UIButton(type: .Custom)
        buttonLeft.addTarget(self, action: Selector("moveLeft"), forControlEvents: .TouchDown)
        buttonLeft.addTarget(self, action: Selector("stop"), forControlEvents: .TouchUpInside)
        self.view!.addSubview(buttonLeft)
        buttonLeft.snp_makeConstraints{ make in
            make.left.equalTo(gamepad)
            make.centerY.equalTo(gamepad)
            make.width.equalTo(buttonD1)
            make.height.equalTo(buttonD2)
        }
        
        let buttonRight = UIButton(type: .Custom)
        buttonRight.addTarget(self, action: Selector("moveRight"), forControlEvents: .TouchDown)
        buttonRight.addTarget(self, action: Selector("stop"), forControlEvents: .TouchUpInside)
        self.view!.addSubview(buttonRight)
        buttonRight.snp_makeConstraints{ make in
            make.right.equalTo(gamepad)
            make.centerY.equalTo(gamepad)
            make.width.equalTo(buttonD1)
            make.height.equalTo(buttonD2)
        }
        
        let jumpButton = UIButton(type: .Custom)
        jumpButton.backgroundColor = UIColorFromRGB("cdcdcd")
        jumpButton.layer.opacity = 0.3
        jumpButton.layer.cornerRadius = 25
        self.view!.addSubview(jumpButton)
        jumpButton.addTarget(self, action: Selector("jump"), forControlEvents: .TouchDown)
        jumpButton.addTarget(self, action: Selector("fall"), forControlEvents: .TouchUpInside)
        jumpButton.snp_makeConstraints{ make in
            make.right.equalTo(self.view!).offset(-100)
            make.size.equalTo(100)
            make.bottom.equalTo(self.view!).offset(-100)
        }

        self.backgroundColor = mainBGColor
        physicsWorld.gravity = CGVectorMake(0, -9.8)
        physicsWorld.contactDelegate = self
        for i in level!.blocks{
            placeObject(CGFloat(i.x), y: CGFloat(i.y), height: 1.0, width: 1.0, asset: globalBlocks[i.block].asset, physicsType: .Block)
        }
        self.char = placeObject(CGFloat(level!.playerCoords.x), y: CGFloat(level!.playerCoords.y), height: 2.0, width: 1.0, asset: "pip", physicsType: Physics.Person)
    }
    
    func stop(){
        self.xRate = 0
        return
    }
    func moveLeft(){
        self.xRate = -1.0
        return
    }
    func moveRight(){
        self.xRate = 1.0
        return
    }
    func jump(){
        self.yRate = 1.0
        return
    }
    
    func fall(){
        self.yRate = 0.0
        return
    }
    
    override func update(currentTime: NSTimeInterval) {
        var xVel = xCharSpeed-self.char!.physicsBody!.velocity.dx
        if self.xRate < 0{
            xVel = xCharSpeed+self.char!.physicsBody!.velocity.dx
        }
        let relativeVelocity: CGVector = CGVectorMake(xVel, yCharSpeed-self.char!.physicsBody!.velocity.dy)
        
        var rawY = self.char!.physicsBody!.velocity.dy+relativeVelocity.dy*yRate
        var rawX = self.char!.physicsBody!.velocity.dx+relativeVelocity.dx*xRate
        
        if rawY == yCharSpeed{
            NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: Selector("fall"), userInfo: nil, repeats: false)
        }
        
        self.char!.physicsBody!.velocity=CGVectorMake(rawX, rawY)
        return
    }
    
    func placeObject(x:CGFloat, y:CGFloat, height:CGFloat, width:CGFloat, asset:String, physicsType: Physics) -> SKSpriteNode{
        let node = SKSpriteNode(imageNamed: asset)
        node.position = CGPoint(x:((x*gridSize)+gridSize/2)*width, y: (((rows-y)*gridSize)*height)-gridSize/2)
        node.size = CGSize(width: width*gridSize, height: height*gridSize)
        switch physicsType{
            case .Block:
                node.physicsBody = SKPhysicsBody(edgeLoopFromRect:CGRect(origin:CGPointMake(-node.size.width/2, -node.size.height/2),size:node.size))
                node.physicsBody!.dynamic = true
                node.physicsBody!.allowsRotation = false
                node.physicsBody!.restitution = 0
                node.physicsBody!.linearDamping = 0
                node.physicsBody!.categoryBitMask = Block
                node.physicsBody!.usesPreciseCollisionDetection = true
                node.name = "Block"
            break;
            case .Person:
                node.physicsBody = SKPhysicsBody(rectangleOfSize: node.size)
                node.physicsBody!.dynamic = true
                node.physicsBody!.restitution = 0
                node.physicsBody!.linearDamping = 0
                node.physicsBody!.allowsRotation = false
                node.physicsBody!.collisionBitMask = Block
                node.physicsBody!.usesPreciseCollisionDetection = true
            break;
            default:
            break;
        }
        addChild(node)
        return node
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        /*A = Block, B = Person
        //Compare bottom of block + gridSize to simple position of character
        let blockPosition = contact.bodyB.node!.position
        let charPosition = contact.bodyA.node!.position
        
        let blockTop = floor(blockPosition.y-gridSize)
        let personBottom = floor(charPosition.y+gridSize/2)
        print("=======")
        print("[Physics] BlockPos: \(blockPosition) | CharPos: \(charPosition)")
        print("[Physics] BlockTop: \(blockTop) | PersonBottom: \(personBottom)")
        print("=======")
        
        if personBottom == blockTop{
            contact.bodyA.friction = 1
            contact.bodyB.friction = 1
        }else{
            contact.bodyA.friction = 0
            contact.bodyB.friction = 0
        }*/
    }
}
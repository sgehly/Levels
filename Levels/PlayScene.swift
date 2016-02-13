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

class PlayScene: SKScene {
    
    //Objects
    var level: Level? = nil
    var char: SKSpriteNode? = nil
    
    //Physics
    let Block:UInt32 = 1 << 0
    let Person:UInt32 = 1 << 1
    var xRate: CGFloat = 0.00
    var yRate: CGFloat = 0.00
    var friction: Bool = false
    var xCharSpeed: CGFloat = 300
    var yCharSpeed: CGFloat = 400
    var currentSpeed: CGFloat = 0.0

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
        
        physicsWorld.gravity = CGVectorMake(0, -9.80665)
        
        for i in level!.blocks{
            placeObject(i.x, y: i.y, height: 1.0, width: 1.0, asset: globalBlocks[i.block].asset, physicsType: .Block)
        }
        self.char = placeObject(CGFloat(level!.playerCoords.x), y: CGFloat(level!.playerCoords.y), height: 2.0, width: 1.0, asset: "pip", physicsType: Physics.Person)
    }
    
    func stop(){
        self.xRate = 0
        return
    }
    func moveLeft(){
        self.xRate = -0.5
        return
    }
    func moveRight(){
        self.xRate = 0.5
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
        
        let rawY = self.char!.physicsBody!.velocity.dy+relativeVelocity.dy*yRate
        var rawX = self.char!.physicsBody!.velocity.dx+relativeVelocity.dx*xRate
        
        //Fake friction
        if rawX < 0 && rawY == 0 && currentSpeed < rawX{
            rawX = 0
        }
        if rawX > 0 && rawY == 0 && currentSpeed > rawX{
            rawX = 0
        }
        currentSpeed = rawX
        
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
                var path = CGPathCreateWithEllipseInRect(node.frame, nil)
                node.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(-node.size.width/2, -node.size.height/2, gridSize, gridSize))
                node.physicsBody?.dynamic = false
            break;
            case .Person:
                let mb = SKPhysicsBody(rectangleOfSize: CGSizeMake(node.size.width,node.size.height-4), center: CGPointMake(0,4))
                mb.friction = 0
                let fb = SKPhysicsBody(rectangleOfSize: CGSizeMake(node.size.width,4), center: CGPointMake(0,-node.size.height/2))
                fb.friction = 1
                node.physicsBody = SKPhysicsBody(bodies: [mb,fb])
                node.physicsBody = SKPhysicsBody(rectangleOfSize: node.size)
                node.physicsBody?.contactTestBitMask = node.physicsBody!.collisionBitMask
                node.physicsBody?.dynamic = true
            break;
            default:
            break;
        }
        node.physicsBody!.usesPreciseCollisionDetection = true
        node.physicsBody!.restitution = 0
        node.physicsBody!.allowsRotation = false
        addChild(node)
        return node
    }
}
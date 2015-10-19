//
//  Levels.swift
//  Levels
//
//  Created by Sam Gehly on 10/19/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//
import SpriteKit
import UIKit
import SnapKit

class Editor: SKScene, UIScrollViewDelegate {
    
    let gridSize = CGFloat(40)
    var rows = 40
    var columns = 800
    let menuHeight = CGFloat(40)
    
    var views: [[UIView]?] = []
    let scroll = UIScrollView()
    
    override func didMoveToView(view: SKView) {
        print("MOVED")
        let menu = UIView()
        menu.backgroundColor = UIColor.whiteColor()
        view.addSubview(menu)
        
        menu.snp_makeConstraints{ make in
            make.top.equalTo(view)
            make.height.equalTo(menuHeight)
            make.width.equalTo(view)
        }
        scroll.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        scroll.delegate = self
        scroll.contentSize = CGSizeMake(CGFloat(columns)*gridSize,CGFloat(rows)*gridSize+CGFloat(menuHeight))
        scroll.alwaysBounceHorizontal = false
        scroll.alwaysBounceVertical = false
        scroll.frame = CGRectMake(0,menuHeight, view.frame.width, view.frame.height)
        
        let bottomPoint = CGPointMake(0, scroll.contentSize.height - scroll.bounds.size.height);
        scroll.setContentOffset(bottomPoint, animated: false)
        
        let user = User(name: "Toby", registered: NSDate(), profilePic: "toby1", flag: "USA")
        let blocks: [[Int?]?] = []
        let level = Level(name: "TestLevel", clearCount: 4, playCount: 8, stars: 2, creator: user, beaten: false, layout: blocks)
        loadLevel(level, rawView: view)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
    
    
    func loadLevel(level: Level, rawView: SKView){
        rawView.backgroundColor = UIColor(red: 102/255, green: 154/255, blue: 210/255, alpha: 1.0)
        rawView.addSubview(scroll)
        draw(level.layout)
    }
    
    func draw(blocks: [[Int?]?]){
        for var hIndex = 0; hIndex < rows; ++hIndex{
            views.insert([], atIndex: hIndex)
            for var vIndex = 0; vIndex < columns; ++vIndex{
                let view = UIView()
                view.frame = CGRectMake(gridSize*CGFloat(vIndex), gridSize*CGFloat(hIndex), gridSize, gridSize)
                view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).CGColor
                view.layer.borderWidth = CGFloat(0.5)
                views[hIndex]?.insert(view, atIndex: vIndex)
                
                if hIndex < blocks.count{
                    //Valid Horizontal Row
                    if blocks[hIndex]!.count+1 > views[hIndex]!.count{
                        //Valid Vertical Column
                        views[hIndex]![vIndex].backgroundColor = UIColor.redColor()
                    }
                }
                
                
                scroll.addSubview(view)
            }
        }
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        print("TEST")
    }
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        print("TEST2")
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

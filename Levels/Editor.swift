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
    let borderWidth = CGFloat(0.5);
    
    let scroll = UIScrollView()
    
    override func didMoveToView(view: SKView) {
        print("MOVED")
        let menu = UIView()
        menu.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1.0)
        view.addSubview(menu)
        
        menu.snp_makeConstraints{ make in
            make.top.equalTo(view)
            make.height.equalTo(menuHeight)
            make.width.equalTo(view)
        }
        scroll.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        scroll.delegate = self
        scroll.contentSize = CGSizeMake(CGFloat(columns)*gridSize,CGFloat(rows)*gridSize+CGFloat(menuHeight))
        scroll.bounces = false
        scroll.frame = CGRectMake(0,menuHeight, view.frame.width, view.frame.height)
        
        let bottomPoint = CGPointMake(0, scroll.contentSize.height - scroll.bounds.size.height);
        scroll.setContentOffset(bottomPoint, animated: false)
        
        let user = User(name: "Toby", registered: NSDate(), profilePic: "toby1", flag: "USA")
        let blocks: [[Int?]?] = [
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil],
            [nil]
        ]
        let level = Level(name: "TestLevel", clearCount: 4, playCount: 8, stars: 2, creator: user, beaten: false, layout: blocks)
        loadLevel(level, rawView: view)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
                    }
    }
    
    
    func loadLevel(level: Level, rawView: SKView){
        scroll.backgroundColor = UIColor(red: 102/255, green: 154/255, blue: 210/255, alpha: 1.0)
        rawView.addSubview(scroll)
        draw(level.layout)
    }
    
    func draw(blocks: [[Int?]?]){
        for var hIndex = 0; hIndex < rows; ++hIndex{
            //Horizontal Borders
            let border = UIView()
            border.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            border.frame = CGRectMake(0,(CGFloat(hIndex)*gridSize)-borderWidth,scroll.contentSize.width,borderWidth)
            scroll.addSubview(border)
        }
        for var vIndex = 0; vIndex < columns; ++vIndex{
            //Vertical Borders
            let border = UIView()
            border.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            border.frame = CGRectMake((CGFloat(vIndex)*gridSize)-borderWidth,0, borderWidth, scroll.contentSize.height)
            scroll.addSubview(border)
        }
        
        for var hIndex = 0; hIndex < blocks.count; ++hIndex{
            for var vIndex = 0; vIndex < blocks[hIndex]!.count; ++vIndex{
                if blocks[hIndex]![vIndex] != nil{
                    print("GOT BLOCK AT (\(hIndex),\(vIndex))")
                    generateBlock(blocks[hIndex]![vIndex]!, frame: CGRectMake(CGFloat(vIndex)*gridSize, CGFloat(hIndex)*gridSize, gridSize, gridSize))
                }
            }
        }

    }
    
    func generateBlock(bID: Int, frame: CGRect){
        print(blocks.count)
        print(bID)
        if blocks.count > bID{
            //ERROR RED ALERT
            return
        }
        let block = blocks[bID-1]
        let node = UIImageView(frame: frame);
        node.image = UIImage(named: block.asset)
        scroll.addSubview(node)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

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

class Editor: SKScene {
    
    let gridSize = CGFloat(50)
    var rows = 40
    var columns = 100
    let menuHeight = CGFloat(60)
    let borderWidth = CGFloat(0.5);
    
    var scroll: LevelScrollView? = nil
    
    override func didMoveToView(view: SKView) {
        self.userInteractionEnabled = true
        let menu = UIView()
        menu.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1.0)
        view.addSubview(menu)
        
        menu.snp_makeConstraints{ make in
            make.top.equalTo(view)
            make.height.equalTo(menuHeight)
            make.width.equalTo(view)
        }
        
        
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
        self.scroll = LevelScrollView(reference: self.view!, rows: rows, columns: columns, gridSize: gridSize, menuHeight: menuHeight)

        loadLevel(level, rawView: view)
    }
    
    
    func loadLevel(level: Level, rawView: SKView){
        rawView.addSubview(scroll!)
        draw(level.layout)
    }
    
    func draw(blocks: [[Int?]?]){
        for var hIndex = 0; hIndex < rows; ++hIndex{
            //Horizontal Borders
            let border = UIView()
            border.userInteractionEnabled = false
            border.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            border.frame = CGRectMake(0,(CGFloat(hIndex)*gridSize)-borderWidth,scroll!.contentSize.width,borderWidth)
            scroll!.addSubview(border)
        }
        for var vIndex = 0; vIndex < columns; ++vIndex{
            //Vertical Borders
            let border = UIView()
            border.userInteractionEnabled = false
            border.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            border.frame = CGRectMake((CGFloat(vIndex)*gridSize)-borderWidth,0, borderWidth, scroll!.contentSize.height)
            scroll!.addSubview(border)
        }
        
        for var hIndex = 0; hIndex < blocks.count; ++hIndex{
            for var vIndex = 0; vIndex < blocks[hIndex]!.count; ++vIndex{
                if blocks[hIndex]![vIndex] != nil{
                    generateBlock(blocks[hIndex]![vIndex]!, frame: CGRectMake(CGFloat(vIndex)*gridSize, CGFloat(hIndex)*gridSize, gridSize, gridSize), reference: scroll!)
                }
            }
        }

    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

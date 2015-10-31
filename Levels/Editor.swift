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
    
    let menuHeight = CGFloat(60)
    var editorScreen: LevelScrollView? = nil
    
    override func didMoveToView(view: SKView) {
        self.userInteractionEnabled = true
        let menu = UIView()
        menu.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1.0)
        view.addSubview(menu)
        
        menu.frame = CGRectMake(0,0, view.frame.width, menuHeight)
    
        
        let user = User(name: "Toby", registered: NSDate(), profilePic: "toby1", flag: "USA")
        let blocks: [[Int?]?] = []
        let level = Level(name: "TestLevel", clearCount: 4, playCount: 8, stars: 2, creator: user, beaten: false, layout: blocks)

        self.editorScreen = LevelScrollView(reference: view, menuHeight: menuHeight)
        
        let navBar = MenuCollectionView(frame: menu.frame, collectionViewLayout: UICollectionViewLayout(), reference: self.editorScreen!)
        
        view.addSubview(navBar)
        
        loadLevel(level, rawView: view)
    }
    
    
    func loadLevel(level: Level, rawView: SKView){
        rawView.addSubview(self.editorScreen!)
        //draw(level.layout)
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

//
//  Play.swift
//  Levels
//
//  Created by Sam Gehly on 11/20/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit


class PlayController: UIViewController{
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = SKView(frame: self.view.frame)
        let scene = PlayScene(level: demoLevel)
        let skView = self.view as! SKView
        //skView.showsFPS = true
        //skView.showsNodeCount = true
        skView.showsPhysics = true
        skView.presentScene(scene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
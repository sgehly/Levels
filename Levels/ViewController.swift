//
//  ViewController.swift
//  Levels
//
//  Created by Sam Gehly on 10/17/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import UIKit
import SpriteKit
import SnapKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Landscape
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = Editor(fileNamed: "Editor"){
            let mainView = self.view as! SKView
            mainView.showsNodeCount = true
            mainView.showsFPS = true
            mainView.ignoresSiblingOrder = true
            scene.scaleMode = .AspectFill
            mainView.presentScene(scene)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


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

    
    //CONFIGURATION

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.All
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let menu = MenuViewController()
        self.view.addSubview(menu.view)
        menu.view.frame = self.view.frame*/
        
        let play = PlayController()
        self.view.addSubview(play.view)

        /*let editorView = Editor(edit: true, blocks: [])
        self.view.addSubview(editorView.view)
        editorView.view.frame = self.view.frame*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


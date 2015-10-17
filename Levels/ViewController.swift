//
//  ViewController.swift
//  Levels
//
//  Created by Sam Gehly on 10/17/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController, UIScrollViewDelegate {

    let gridSize = CGFloat(40)
    var rows = 200
    var columns = 20
    
    var views: [[UIView]?] = []
    let scroll = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scroll.delegate = self
        scroll.contentSize = CGSizeMake(CGFloat(rows)*gridSize,CGFloat(columns)*gridSize)
        self.view.addSubview(scroll)
        scroll.frame = CGRectMake(0,0,self.view.frame.width,self.view.frame.height)
        
        let user = User(name: "Toby", registered: NSDate(), profilePic: "toby1", flag: "USA")
        let blocks: [[Int?]?] = [[],[],[],[],[],[],[],[],[],[1,1,1,1,1]]
        let level = Level(name: "TestLevel", clearCount: 4, playCount: 8, stars: 2, creator: user, beaten: false, layout: blocks)
        loadLevel(level)
    }
    
    func loadLevel(level: Level){
        /*let bg = UIImageView(image: UIImage(named: "background"))
        bg.frame = CGRectMake(0,0,self.view.frame.width,self.view.frame.height)
        self.view.addSubview(bg)*/
        drawGrid()
    }
    
    func drawGrid(){
        
        for var hIndex = 0; hIndex < rows; ++hIndex{
            views.insert([], atIndex: hIndex)
            for var vIndex = 0; vIndex < rows; ++vIndex{
                let view = UIView()
                view.backgroundColor = UIColor.grayColor()
                view.frame = CGRectMake(gridSize*CGFloat(vIndex), gridSize*CGFloat(hIndex), gridSize, gridSize)
                
                generateBorder(view)
                views[hIndex]?.insert(view, atIndex: vIndex)
                scroll.addSubview(view)
            }
        }
    }
    
    func generateBorder(view: UIView){
        let bottom = CALayer()
        let width = CGFloat(1.0)
        bottom.borderColor = UIColor.darkGrayColor().CGColor
        bottom.frame = CGRect(x: 0, y: view.frame.size.height-width, width: view.frame.size.width, height: view.frame.size.height)
        bottom.borderWidth = width
        
        let right = CALayer()
        right.borderColor = UIColor.darkGrayColor().CGColor
        right.frame = CGRect(x: view.frame.size.width-width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        right.borderWidth = width

        view.layer.addSublayer(bottom)
        view.layer.addSublayer(right)
        view.layer.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


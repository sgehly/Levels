//
//  LevelScrollView.swift
//  Levels
//
//  Created by Sam Gehly on 10/19/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import Foundation
import UIKit

class LevelScrollView: UIScrollView, UIScrollViewDelegate{
    
    var gridSize = CGFloat(50)
    var rows = CGFloat(40)
    var columns = CGFloat(100)
    var reference = UIView()
    var prevLoc: CGRect? = nil
    var selected = 0
    var drawScale: CGFloat = 1
    
    var blocks: [(x: Int, y: Int, block: Block)!] = []
    
    init(reference: UIView, menuHeight: CGFloat){
        super.init(frame: CGRectMake(0, menuHeight, reference.frame.width, reference.frame.height-menuHeight))
        
        self.reference = reference
        self.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        self.delegate = self
        self.contentSize = CGSizeMake(CGFloat(columns)*CGFloat(gridSize)*drawScale,CGFloat(rows)*CGFloat(gridSize)*drawScale)
        self.bounces = false
        self.userInteractionEnabled = true
        self.panGestureRecognizer.minimumNumberOfTouches = 2
        self.backgroundColor = UIColor(red: 102/255, green: 154/255, blue: 210/255, alpha: 1.0)

        
        let customZoom = UIPinchGestureRecognizer(target: self, action: Selector("zoom:"))
        self.addGestureRecognizer(customZoom)
        
        let bottomPoint = CGPointMake(0, self.contentSize.height - self.bounds.size.height);
        self.setContentOffset(bottomPoint, animated: false)
        drawLines()
    }
    
    func drawLines(){
        for var i: CGFloat = 0; i<rows; ++i{
            let hL = UIView()
            hL.frame = CGRectMake(0, i*gridSize*drawScale, columns*gridSize*drawScale, 0.5)
            hL.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            self.addSubview(hL)
        }
        for var i: CGFloat = 0; i<columns; ++i{
            let vL = UIView()
            vL.frame = CGRectMake(i*gridSize*drawScale, 0, 0.5, rows*gridSize*drawScale)
            vL.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            self.addSubview(vL)
        }
    }
    
    func zoom(sender: UIPinchGestureRecognizer){
        let newScale = self.drawScale + (sender.scale-self.drawScale)
        self.drawScale = newScale
        
        if (sender.state == UIGestureRecognizerState.Ended)
        {
            drawScale = 1;
            return;
        }
        
        drawScale = sender.scale;
        self.setNeedsDisplay()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.count == 1{
            for touch in touches{
                processTouch(touch)
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.count == 1{
            for touch in touches{
              processTouch(touch)
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.count == 1{
            for touch in touches{
                processTouch(touch)
            }
        }
    }
    
    func processTouch(touch: UITouch){
        let gs = CGFloat(gridSize)
        let x = CGFloat(Int(touch.locationInView(self).x/gs))*gs
        let y = CGFloat(Int(touch.locationInView(self).y/gs))*gs
        
        if self.prevLoc != frame{
            blocks.append((x: Int(x), y: Int(y), block: globalBlocks[self.selected]))
            let block = generateBlock(self.selected, frame: CGRectMake(x, y, gs, gs), reference: self)
            self.prevLoc = frame
            self.addSubview(block)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
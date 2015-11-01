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
    
    //Editor Configuration
    var gridSize = CGFloat(50)
    var rows = CGFloat(40)
    var columns = CGFloat(100)
    var reference = UIView()
    var prevLoc: CGRect? = nil
    var selected = 0
    
    //For upload. No touchy.
    var blocks: [(x: CGFloat, y: CGFloat, block: Block)] = []
    
    init(reference: UIView){
        super.init(frame: CGRectMake(80, 0, reference.frame.width, reference.frame.height))
        self.reference = reference
        self.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        self.delegate = self
        self.bounces = false
        self.userInteractionEnabled = true
        self.panGestureRecognizer.minimumNumberOfTouches = 2
        self.backgroundColor = UIColor(red: 102/255, green: 154/255, blue: 210/255, alpha: 1.0)
        self.contentSize = CGSizeMake(CGFloat(columns)*CGFloat(gridSize),CGFloat(rows)*CGFloat(gridSize))
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("processTouch:"))
        tap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tap)

        let pan = UIPanGestureRecognizer(target: self, action: Selector("processTouch:"))
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 1
        self.addGestureRecognizer(pan)
        processView()
                
    }
    
    
    func processView(){
        let bottomPoint = CGPointMake(0, self.contentSize.height - self.bounds.size.height);
        self.setContentOffset(bottomPoint, animated: false)
        drawLines()

    }
    
    func drawLines(){
        for var i: CGFloat = 0; i<rows; ++i{
            let hL = UIView()
            hL.tag = Int(i)
            hL.frame = CGRectMake(0, i*gridSize, columns*gridSize, 0.5)
            hL.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            self.addSubview(hL)
        }
        for var i: CGFloat = 0; i<columns; ++i{
            let vL = UIView()
            vL.tag = Int(i)
            vL.frame = CGRectMake(i*gridSize, 0, 0.5, rows*gridSize)
            vL.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            self.addSubview(vL)
        }
    }
    
    
    func processTouch(sender: UIGestureRecognizer){
        let gs = gridSize
        
        let x = CGFloat(Int(sender.locationInView(self).x/gs))
        let y = CGFloat(Int(sender.locationInView(self).y/gs))
        let frame = CGRectMake(x*gs, y*gs, gs, gs)
        if self.prevLoc != frame{
            let block = generateBlock(self.selected, frame: frame, reference: self)
            self.prevLoc = frame
            self.addSubview(block)
            blocks.append((x: x, y: y, block: globalBlocks[self.selected]))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
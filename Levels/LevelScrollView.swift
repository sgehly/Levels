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
    var reference = UIScrollView()
    var prevLoc: CGRect? = nil
    var selected = 0
    var edit = true
    
    //For upload. No touchy.
    var blocks: [(x: CGFloat, y: CGFloat, block: Int)] = []
    
    init(reference: UIScrollView, edit: Bool, level: Level){
        super.init(frame: CGRectMake(0, 0, reference.frame.width, reference.frame.height))
        
        if !edit{
            gridSize = reference.superview!.frame.width/15
        }
        
        self.edit = edit
        self.blocks = level.blocks
        self.reference = reference
        self.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        self.delegate = self
        self.bounces = false
        self.panGestureRecognizer.delaysTouchesBegan = true
        self.pinchGestureRecognizer?.delaysTouchesBegan = true
        self.userInteractionEnabled = true
        self.delaysContentTouches = true
        self.panGestureRecognizer.minimumNumberOfTouches = 2
        self.backgroundColor = mainBGColor
        self.contentSize = CGSizeMake(CGFloat(columns)*CGFloat(gridSize),CGFloat(rows)*CGFloat(gridSize))
        let bottomPoint = CGPointMake(0, self.contentSize.height - self.bounds.size.height);
        self.setContentOffset(bottomPoint, animated: false)
        
        if edit{
            let tap = UITapGestureRecognizer(target: self, action: Selector("processTouch:"))
            tap.numberOfTouchesRequired = 1
            tap.delaysTouchesBegan = true
            self.addGestureRecognizer(tap)
            
            let pan = UIPanGestureRecognizer(target: self, action: Selector("processTouch:"))
            pan.minimumNumberOfTouches = 1
            pan.maximumNumberOfTouches = 1
            pan.delaysTouchesBegan = true
            self.addGestureRecognizer(pan)
        }
        processView()

        for i in blocks{
            placeBlock(i.x, y: i.y, block: i.block)
        }
    }
    
    
    func processView(){
        drawLines()

    }
    
    func drawLines(){
        for var i: CGFloat = 0; i<rows; ++i{
            let hL = UIView()
            hL.tag = Int(i)
            hL.frame = CGRectMake(0, i*gridSize, columns*gridSize, 1)
            hL.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            self.addSubview(hL)
        }
        for var i: CGFloat = 0; i<columns; ++i{
            let vL = UIView()
            vL.tag = Int(i)
            vL.frame = CGRectMake(i*gridSize, 0, 1, rows*gridSize)
            vL.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            self.addSubview(vL)
        }
    }
    
    
    func processTouch(sender: UIGestureRecognizer){
        let gs = gridSize
        let x = CGFloat(Int(sender.locationInView(self).x/gs))
        let y = CGFloat(Int(sender.locationInView(self).y/gs))
        let frame = CGRectMake((x*gs)+0.5, (y*gs)+0.5, gs, gs)
        if self.prevLoc != frame{
            let block = generateBlock(self.selected, frame: frame, reference: self)
            self.prevLoc = frame
            self.addSubview(block)
            blocks.append((x: x, y: y, block: self.selected))
            print(blocks)
        }
    }
    
    func placeBlock(x: CGFloat, y: CGFloat, block: Int){
        var frame = CGRectMake(CGFloat(x*gridSize)+0.5, y*gridSize+0.5, gridSize, gridSize)
        let block = generateBlock(block, frame: frame, reference: self)
        self.prevLoc = frame
        self.addSubview(block)
        print(block)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
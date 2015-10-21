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
    
    var gridSize: CGFloat? = nil;
    var rows: Int? = nil
    var columns: Int? = nil
    var reference = UIView()
    var transBlock: UIView? = nil
    var prevLoc: CGRect? = nil
    
    
    init(reference: UIView, rows: Int, columns: Int, gridSize: CGFloat, menuHeight: CGFloat){
        super.init(frame: CGRectMake(0, menuHeight, reference.frame.width, reference.frame.height-menuHeight))
        
        self.reference = reference
        self.rows = rows
        self.columns = columns
        self.gridSize = gridSize
        self.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        self.delegate = self
        self.contentSize = CGSizeMake(CGFloat(columns)*gridSize,CGFloat(rows)*gridSize)
        self.bounces = false
        self.userInteractionEnabled = true
        self.delaysContentTouches = false
        self.panGestureRecognizer.minimumNumberOfTouches = 2
        self.panGestureRecognizer.delaysTouchesBegan = false
        self.panGestureRecognizer.delaysTouchesEnded = false
        self.zoomScale = 0.4
        self.backgroundColor = UIColor(red: 102/255, green: 154/255, blue: 210/255, alpha: 1.0)

        let bottomPoint = CGPointMake(0, self.contentSize.height - self.bounds.size.height);
        self.setContentOffset(bottomPoint, animated: false)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /*if self.transBlock != nil{
            self.transBlock!.removeFromSuperview()
        }*/
        
        if touches.count == 1{
            for touch in touches{
                let frame = CGRectMake(CGFloat(Int(touch.locationInView(self).x/gridSize!))*gridSize!,CGFloat(Int(touch.locationInView(self).y/gridSize!))*gridSize!, gridSize!, gridSize!)
                
                if self.prevLoc != frame{
                    let block = generateBlock(1, frame: frame, reference: self)
                    self.prevLoc = frame
                    self.addSubview(block)
                }
                
                /*self.transBlock = block
                self.addSubview(self.transBlock!)*/
            }
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return scrollView
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.count == 1{
            for touch in touches{
                generateBlock(1, frame: CGRectMake(CGFloat(Int(touch.locationInView(self).x/gridSize!))*gridSize!,CGFloat(Int(touch.locationInView(self).y/gridSize!))*gridSize!, gridSize!, gridSize!), reference: self)
            }
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
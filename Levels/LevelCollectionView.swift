//
//  LevelCollectionView.swift
//  Levels
//
//  Created by Sam Gehly on 10/23/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import Foundation
import UIKit

class LevelCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let gridSize = CGFloat(50)
    var rows = 60
    var columns = 100
    let borderWidth = CGFloat(0.5)
    var selected = 0
    var blocks: [[Int?]?] = []
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let levelLayout = LevelFlowLayout(itemWidth: gridSize, itemHeight: gridSize, space: 0)
        super.init(frame: frame, collectionViewLayout: levelLayout)
        self.delegate = self
        self.dataSource = self
        self.panGestureRecognizer.minimumNumberOfTouches = 2
        self.panGestureRecognizer.maximumNumberOfTouches = 2
        registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "blockCell")
        self.backgroundColor = UIColor(red: 102/255, green: 154/255, blue: 210/255, alpha: 1.0)
    
        
        let touchGesture = UIPanGestureRecognizer(target: self, action: Selector("addBlockProxy:"))
        touchGesture.maximumNumberOfTouches = 1
        touchGesture.minimumNumberOfTouches = 1
        self.addGestureRecognizer(touchGesture)

        let tap = UITapGestureRecognizer(target: self, action: Selector("addBlockProxy:"))
        tap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tap)

    }
    
    func addBlockProxy(sender: UIPanGestureRecognizer){
        if sender.numberOfTouches() == 1{
            let point = CGPointMake(sender.locationInView(self).x/gridSize, sender.locationInView(self).y/gridSize)
            let ip = NSIndexPath(forItem: Int(point.x), inSection: Int(point.y))
            draw(ip)
        }
    }
    
    func draw(ip: NSIndexPath){
        let cell = self.cellForItemAtIndexPath(ip)
        cell?.contentView.addSubview(UIImageView(image: UIImage(named: globalBlocks[selected].asset)))
        self.reloadItemsAtIndexPaths([ip])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCellWithReuseIdentifier("blockCell", forIndexPath: indexPath)
        cell.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).CGColor
        cell.layer.borderWidth = borderWidth
        cell.layer.shouldRasterize = true;
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale;
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columns
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return rows
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //self.selected = indexPath.row
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(0,0,0,0)
    }
    
}
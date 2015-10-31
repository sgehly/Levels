//
//  MenuCollectionView.swift
//  Levels
//
//  Created by Sam Gehly on 10/21/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import Foundation
import UIKit

class MenuCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var ref: LevelScrollView? = nil
    
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, reference: LevelScrollView) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 40,height: 40)
        layout.scrollDirection = .Horizontal
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.ref = reference
        registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "menuCell")
        let bottomPoint = CGPointMake(0, self.contentSize.height - self.bounds.size.height);
        self.setContentOffset(bottomPoint, animated: false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return globalBlocks.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let image = UIImageView()
        image.image = UIImage(named: globalBlocks[indexPath.row].asset)
        image.layer.cornerRadius = 5
        image.backgroundColor = UIColor.blackColor()
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.whiteColor().CGColor
        image.layer.masksToBounds = true
        let cell = self.dequeueReusableCellWithReuseIdentifier("menuCell", forIndexPath: indexPath)
        cell.contentView.addSubview(image)
        image.frame = cell.contentView.frame
        cell.layer.shouldRasterize = true;
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale;
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.ref!.selected = indexPath.row
    }
}
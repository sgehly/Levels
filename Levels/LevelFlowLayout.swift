//
//  File.swift
//  Levels
//
//  Created by Sam Gehly on 10/23/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import Foundation
import UIKit

class LevelFlowLayout : UICollectionViewFlowLayout {
    
    var itemWidth : CGFloat
    var itemHeight : CGFloat
    var space : CGFloat
    
    init(itemWidth: CGFloat, itemHeight: CGFloat, space: CGFloat) {
        self.itemWidth = itemWidth
        self.itemHeight = itemHeight
        self.space = space
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionViewContentSize() -> CGSize {
        let w : CGFloat = CGFloat(self.collectionView!.numberOfItemsInSection(0)) * (itemWidth)
        let h : CGFloat = CGFloat(self.collectionView!.numberOfSections()) * (itemHeight)
        return CGSizeMake(w, h)
    }
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes {
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        let x : CGFloat = CGFloat(indexPath.row) * (itemWidth)
        let y : CGFloat = CGFloat(indexPath.section) * (itemHeight)
        attributes.frame = CGRectMake(x, y, itemWidth, itemHeight)
        return attributes
    }
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let minRow : Int = (rect.origin.x > 0) ? Int(floor(rect.origin.x/(itemWidth + space))) : 0
        let maxRow : Int = Int(floor(rect.size.width/(itemWidth + space)) + CGFloat(minRow))
        var attributes : Array<UICollectionViewLayoutAttributes> = [UICollectionViewLayoutAttributes]()
        for i in 0...self.collectionView!.numberOfSections()-1 {
            for j in minRow...maxRow {
                attributes.append(self.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: j, inSection: i)))
            }
        }
        return attributes
    }
}
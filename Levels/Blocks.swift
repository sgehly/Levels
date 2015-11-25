//
//  File.swift
//  Levels
//
//  Created by Sam Gehly on 10/17/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import Foundation
import UIKit

public struct Solid {
    public var Top: Bool?
    public var Bottom: Bool?
    public var Left: Bool?
    public var Right: Bool?
}

public struct Modifier{
    public var Death: Bool?
    public var Teleport: Bool?
    public var Bounce: Bool?
}

public struct Block {
    public var asset: String
    public var action: Modifier?
    public var solid: Solid?
}

func generateBlock(bID: Int, frame: CGRect, reference: UIView) -> UIView{
    if globalBlocks.count < bID{
        print("Block not found")
        return UIView()
    }
    let block = globalBlocks[bID]
    let node = UIImageView(frame: frame);
    node.image = UIImage(named: block.asset)
    return node
}

func generateTranslucentBlock(bID: Int, frame: CGRect)->UIView{
    var block: Block? = nil
    
    if globalBlocks.count > bID{
        block = globalBlocks[0]
    }else{
        block = globalBlocks[bID-1]
    }
    let node = UIImageView(frame: frame);
    node.layer.opacity = 0.4
    node.image = UIImage(named: block!.asset)
    return node
}
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

let blocks = [
    //These are searched for by the position in the array. DO NOT edit the order. Only add new blocks.
    Block(asset: "Grass", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
]

let dummyLevel = [
    [blocks[0],blocks[0],blocks[0],blocks[0]]
]

func generateBlock(bID: Int, frame: CGRect, reference: UIView) -> UIView{
    if blocks.count > bID{
        return UIView()
    }
    let block = blocks[bID-1]
    let node = UIImageView(frame: frame);
    node.image = UIImage(named: block.asset)
    return node
}

func generateTranslucentBlock(bID: Int, frame: CGRect)->UIView{
    var block: Block? = nil
    
    if blocks.count > bID{
        block = blocks[0]
    }else{
        block = blocks[bID-1]
    }
    let node = UIImageView(frame: frame);
    node.layer.opacity = 0.4
    node.image = UIImage(named: block!.asset)
    return node
}
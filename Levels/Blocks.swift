//
//  File.swift
//  Levels
//
//  Created by Sam Gehly on 10/17/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import Foundation

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
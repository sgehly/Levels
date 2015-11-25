//
//  Configuration.swift
//  Levels
//
//  Created by Sam Gehly on 11/20/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import Foundation
import UIKit

var gridSize = CGFloat(50)
var rows = CGFloat(40)
var columns = CGFloat(100)

let demoLevel = Level(name: "Test",
    clearCount: 20,
    playCount: 50,
    stars: 3,
    creator: User(name: "TobyG123", registered: NSDate(), profilePic: "gehly", flag: "USA"),
    beaten: false,
    playerCoords: (3,36),
    theme: Theme.retro,
    blocks: [
        (x:0,y:39, block: 0),
        (x:0,y:38, block: 0),
        (x:0,y:37, block: 0),
        (x:1,y:39, block: 0),
        (x:2,y:39, block: 0),
        (x:3,y:39, block: 0),
        (x:4,y:39, block: 0),
        (x:5,y:39, block: 0),
        
        (x:6,y:39, block: 0),
        (x:7,y:39, block: 0),
        (x:8,y:39, block: 0),
        (x:9,y:39, block: 0),
        (x:10,y:39, block: 0),
        (x:11,y:39, block: 0),
        (x:11,y:38, block: 0),
        (x:11,y:37, block: 0),
    ]
)

let globalBlocks: [Block] = [
    //These are searched for by the position in the array. DO NOT edit the order. Only add new blocks.
    Block(asset: "Grass", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "liquidLava", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "liquidWater", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "castleCenter", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "sandCenter", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "castleMid", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "dirtCenter", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "sandMid", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "sign", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "signExit", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "signLeft", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "dirtMid", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "signRight", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "fence", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "snowCenter", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "fenceBroken", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "grassCenter", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "snowMid", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "stoneCenter", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "grassMid", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "stoneMid", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
    Block(asset: "window", action: nil, solid: Solid(Top: true, Bottom: true, Left: true, Right: true)),
]
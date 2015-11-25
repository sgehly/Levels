//
//  Level.swift
//  Levels
//
//  Created by Sam Gehly on 10/17/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import Foundation

public struct Level{
    public var name: String
    public var clearCount: Int
    public var playCount: Int
    public var stars: Int
    public var creator: User
    public var beaten: Bool
    public var playerCoords: (x: Int, y: Int)
    public var theme: Theme
    public var blocks: [(x: Int, y: Int, block: Int)]
}

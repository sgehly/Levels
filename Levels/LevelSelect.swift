//
//  LevelSelectSP.swift
//  Levels
//
//  Created by Sam Gehly on 11/14/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import Foundation
import UIKit

class LevelSelect: UIViewController{
    
    var levels: [Level] = []
    var menuType: MenuType = .SP
    var menuRef: LevelSelectView? = nil
    
    init(levels: [Level], type: MenuType){
        super.init(nibName: nil, bundle: nil)
        self.levels = levels
        self.menuType = type
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = mainBGColor
        self.menuRef = LevelSelectView(frame: self.view.frame, style: .Plain, levels: levels, menuType: menuType)
        self.view.addSubview(self.menuRef!)
    }
}
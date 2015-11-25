//
//  Menu.swift
//  Levels
//
//  Created by Sam Gehly on 11/6/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController{
    init(){
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        
        let level = Editor(edit: false, blocks: [
            (x:0, y:39, block: 0),
            (x:1, y:39, block: 0),
            (x:1, y:38, block: 3),
            (x:1, y:37, block: 3),
            (x:1, y:36, block: 3),
            (x:1, y:35, block: 3),
            (x:2, y:39, block: 0),
            (x:2, y:38, block: 3),
            (x:2, y:37, block: 3),
            (x:2, y:36, block: 3),
            (x:1, y:36, block: 21),
            (x:3, y:38, block: 3),
            (x:3, y:37, block: 3),
            (x:3, y:36, block: 3),
            (x:3, y:35, block: 3),
            (x:3, y:39, block: 0),
            (x:3, y:36, block: 21),
            (x:4, y:39, block: 0),
            (x:5, y:39, block: 0),
            (x:6, y:39, block: 0),
            (x:7, y:39, block: 0),
            (x:8, y:39, block: 0),
            (x:9, y:39, block: 0),
            (x:10, y:39, block: 0),
            (x:11, y:39, block: 0),
            (x:12, y:39, block: 0),
            (x:12, y:38, block: 3),
            (x:12, y:37, block: 12),
            (x:13, y:39, block: 0),
            (x:14, y:39, block: 0),
            ])
        self.view.addSubview(level.view)
        level.view.frame = self.view.frame
        
        self.view.backgroundColor = UIColorFromRGB("5297c7")
        let logo = UIImageView(image: UIImage(named: "logov1"))
        logo.contentMode = UIViewContentMode.ScaleAspectFit
        self.view.addSubview(logo)
        logo.snp_makeConstraints{ make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(30)
            make.width.equalTo(self.view).offset(-150)
        }
        
        let play = UIButton()
        play.backgroundColor = mainButtonColor
        play.setTitle("PLAY", forState: .Normal)
        self.view.addSubview(play)
        play.layer.cornerRadius = 3
        play.layer.masksToBounds = true
        play.setTitleColor(UIColor.blackColor(), forState: .Normal)
        play.titleLabel?.font = UIFont(name: "Menlo-Regular", size: 52)
        play.snp_makeConstraints{ make in
            make.width.equalTo(logo).offset(-300)
            make.top.equalTo(logo.snp_bottom).offset(30)
            make.centerX.equalTo(self.view)
        }
        let make = UIButton()
        make.backgroundColor = mainButtonColor
        make.setTitle("CREATE", forState: .Normal)
        self.view.addSubview(make)
        make.layer.cornerRadius = 3
        make.layer.masksToBounds = true
        make.setTitleColor(UIColor.blackColor(), forState: .Normal)
        make.titleLabel?.font = UIFont(name: "Menlo-Regular", size: 52)
        make.snp_makeConstraints{ make in
            make.width.equalTo(play)
            make.top.equalTo(play.snp_bottom).offset(10)
            make.centerX.equalTo(self.view)
        }

        
        self.view.bringSubviewToFront(logo)
    }
}
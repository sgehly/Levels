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
    
    let play = UIButton()
    let logo = UIImageView(image: UIImage(named: "logov1"))
    let make = UIButton()

    init(){
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        
        let level = Editor(edit: false, blocks: demoLevel.blocks)
        self.view.addSubview(level.view)
        level.view.frame = self.view.frame
        
        self.view.backgroundColor = UIColorFromRGB("5297c7")
        logo.contentMode = UIViewContentMode.ScaleAspectFit
        self.view.addSubview(logo)
        logo.snp_makeConstraints{ make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(30)
            make.width.equalTo(self.view).offset(-150)
        }
        
        play.backgroundColor = mainButtonColor
        play.setTitle("PLAY", forState: .Normal)
        self.view.addSubview(play)
        play.layer.cornerRadius = 3
        play.layer.masksToBounds = true
        play.setTitleColor(UIColor.blackColor(), forState: .Normal)
        play.titleLabel?.font = mainFont
        play.addTarget(self, action: Selector("moveToPlay"), forControlEvents: .TouchDown)
        play.snp_makeConstraints{ make in
            make.width.equalTo(logo).offset(-300)
            make.top.equalTo(logo.snp_bottom).offset(30)
            make.centerX.equalTo(self.view)
        }

        make.backgroundColor = mainButtonColor
        make.setTitle("CREATE", forState: .Normal)
        self.view.addSubview(make)
        make.layer.cornerRadius = 3
        make.layer.masksToBounds = true
        make.setTitleColor(UIColor.blackColor(), forState: .Normal)
        make.titleLabel?.font = mainFont
        make.snp_makeConstraints{ make in
            make.width.equalTo(play)
            make.top.equalTo(play.snp_bottom).offset(10)
            make.centerX.equalTo(self.view)
        }
        
        self.view.bringSubviewToFront(logo)
    }
    
    func moveToPlay(){
        let playController = LevelSelectView(frame: self.view.frame, style: .Plain, levels: [demoLevel, demoLevel, demoLevel, demoLevel, demoLevel, demoLevel, demoLevel, demoLevel, demoLevel, demoLevel, demoLevel, demoLevel, demoLevel, demoLevel, demoLevel], menuType: MenuType.SP)
        playController.alpha = 0.0
        self.view.addSubview(playController)
        UIView.animateWithDuration(NSTimeInterval(0.25), animations: {
            self.play.alpha = 0.0
            self.make.alpha = 0.0
            self.logo.alpha = 0.0
            playController.alpha = 1.0
            }, completion: { (value: Bool) in
        })
    }
}
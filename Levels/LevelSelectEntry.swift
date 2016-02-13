//
//  LevelSelectEntry.swift
//  Levels
//
//  Created by Sam Gehly on 12/4/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import Foundation
import UIKit

class LevelSelectEntry: UITableViewCell{
    
    let backWidth:CGFloat = 40
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, level: Level) {
        super.init(style: .Default, reuseIdentifier: "levelSelect")
        self.contentView.backgroundColor = mainButtonColor
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        let playButton = UIView()
        playButton.backgroundColor = UIColor.blackColor()
        playButton.layer.cornerRadius = 5
        playButton.layer.masksToBounds = true
        self.contentView.addSubview(playButton)
        playButton.snp_makeConstraints{ make in
            make.top.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(self.contentView).offset(-10)
            make.width.equalTo(playButton.snp_height)
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-10)
        }
        
        let editButton = UIView()
        editButton.backgroundColor = UIColor.blackColor()
        editButton.layer.cornerRadius = 5
        editButton.layer.masksToBounds = true
        self.contentView.addSubview(editButton)
        editButton.snp_makeConstraints{ make in
            make.top.equalTo(playButton)
            make.bottom.equalTo(playButton)
            make.width.equalTo(playButton)
            make.centerY.equalTo(playButton)
            make.right.equalTo(playButton.snp_left).offset(-10)
        }
        
        let image = UIImageView(image: UIImage(named: "bg1"))
        image.contentMode = UIViewContentMode.ScaleAspectFill
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        self.contentView.addSubview(image)
        image.snp_makeConstraints{ make in
            make.right.equalTo(editButton.snp_left).offset(-10)
            make.left.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(editButton)
            make.top.equalTo(editButton)
        }
        
        let text = UILabel()
        text.text = level.name
        text.layer.shadowColor = UIColor.blackColor().CGColor
        text.layer.shadowOffset = CGSizeMake(0,0)
        text.layer.shadowOpacity = 1.0
        text.font = UIFont(name: "HelveticaNeue-Bold", size: 36)
        text.textColor = UIColor.whiteColor()
        self.contentView.addSubview(text)
        text.snp_makeConstraints{ make in
            make.top.equalTo(image).offset(5)
            make.left.equalTo(image).offset(20)
        }
        
        let avatarSize: CGFloat = 30
        
        let avatar = UIImageView(image: UIImage(named: "av"))
        avatar.layer.cornerRadius = avatarSize/2
        avatar.layer.masksToBounds = true
        self.contentView.addSubview(avatar)
        avatar.snp_makeConstraints{ make in
            make.bottom.equalTo(image).offset(-5)
            make.left.equalTo(text)
            make.height.equalTo(avatarSize)
            make.width.equalTo(avatarSize)
        }
        
        let name = UILabel()
        name.text = "TobyG123"
        name.layer.shadowColor = UIColor.blackColor().CGColor
        name.layer.shadowOffset = CGSizeMake(0,0)
        name.layer.shadowOpacity = 1.0
        name.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        name.textColor = UIColor.whiteColor()
        self.contentView.addSubview(name)
        name.snp_makeConstraints{ make in
            make.centerY.equalTo(avatar)
            make.left.equalTo(avatar.snp_right).offset(10)
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
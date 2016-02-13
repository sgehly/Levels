//
//  LevelSelector.swift
//  Levels
//
//  Created by Sam Gehly on 11/26/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class LevelSelectView: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    var levels: [Level] = []
    var menuType: MenuType = .SP
    let frameWidth: CGFloat = 75
    let cellHeight: CGFloat = 100
    
    init(frame: CGRect, style: UITableViewStyle, levels: [Level], menuType: MenuType) {
        super.init(frame: CGRectMake(frameWidth/2, 0, frame.width-frameWidth, frame.height), style: style)
        self.delegate = self
        self.dataSource = self
        self.levels = levels
        self.menuType = menuType
        
        let headerText = UILabel()
        
        var header = ""
        var subtitle = ""
        
        switch menuType{
        case .SP:
            header = "Select Your Level"
            subtitle = "These are all of the levels you have created on this device."
            break;
        case .MP:
            header = "Browse Levels"
            subtitle = "Browse featured levels or search for users, levels, or level codes below."
            break;
        }
        
        let headerView = UIView()
        self.backgroundColor = UIColor.clearColor()
        //headerView.frame = CGRectMake(0,0,self.frame.width,100)
        self.tableHeaderView = headerView
        self.separatorStyle = .None
        self.showsVerticalScrollIndicator = false
        
        headerText.text = header
        headerText.font = mainFont
        headerText.textColor = UIColor.whiteColor()
        headerView.addSubview(headerText)
        
        let subText = UILabel()
        subText.text = subtitle
        subText.font = mainSubFont
        subText.textColor = UIColor.whiteColor()
        headerView.addSubview(subText)
        
        self.registerClass(LevelSelectEntry.self, forCellReuseIdentifier: "levelSelect")
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = LevelSelectEntry(style: .Default, reuseIdentifier: "levelSelect", level: demoLevel)
        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let empty = UIView()
        empty.backgroundColor = UIColor.clearColor()
        return empty
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let empty = UIView()
        empty.backgroundColor = UIColor.clearColor()
        return empty
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return levels.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight
    }
    
}
//
//  Levels.swift
//  Levels
//
//  Created by Sam Gehly on 10/19/15.
//  Copyright © 2015 Sam Gehly. All rights reserved.
//
import UIKit
import SnapKit

class Editor: UIViewController, UIScrollViewDelegate {
    
    let menuHeight = CGFloat(60)
    var edit = true
    var editor: LevelScrollView? = nil
    let sc = UIScrollView()
    var blocks: [(x: CGFloat, y: CGFloat, block: Int)] = []
    
    init(edit: Bool, blocks: [(x: CGFloat, y: CGFloat, block: Int)]){
        super.init(nibName: nil, bundle: nil)
        self.edit = edit
        self.blocks = blocks
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        self.view.addSubview(sc)
        
        let editor = LevelScrollView(reference: sc, edit: edit, level: demoLevel)
        sc.delegate = self

        editor.frame = CGRectMake(0, sc.frame.minY, sc.frame.width, sc.frame.height)
        self.editor = editor
        sc.addSubview(editor)
        sc.backgroundColor = UIColor.blackColor()
        
        if edit{
            let menu = UIView()
            menu.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1.0)
            self.view.addSubview(menu)
            menu.frame = CGRectMake(0,0, view.frame.width, menuHeight)
            let navBar = MenuCollectionView(frame: menu.frame, collectionViewLayout: UICollectionViewLayout(), reference: editor)
            menu.addSubview(navBar)
            sc.minimumZoomScale = 0.5
            sc.maximumZoomScale = 4.0
            sc.zoomScale = 0.5
            sc.frame = CGRectMake(0,menuHeight,self.view.frame.width,self.view.frame.height-menuHeight)
        }else{
            sc.zoomScale = 0.5
            sc.frame = CGRectMake(0,0,self.view.frame.width,self.view.frame.height)
            sc.scrollEnabled = false
            editor.scrollEnabled = false
        }
        
        sc.bouncesZoom = false
        sc.scrollEnabled = false
        
        var helloWorldTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("checkPinch"), userInfo: nil, repeats: true)
    }
    func checkPinch(){
    }
    func scrollViewDidZoom(scrollView: UIScrollView) {
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return sc.subviews[0]
    }
    
}

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
    var editor: LevelScrollView? = nil
    var scrollProxy = UIScrollView()
    var img = UIImageView(image: UIImage(named: "brick"))
    
    override func viewDidLoad() {
        let contentFrame = CGRectMake(0,menuHeight,self.view.frame.width,self.view.frame.height-menuHeight)
        scrollProxy.userInteractionEnabled = true
        scrollProxy.delegate = self
        scrollProxy.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        scrollProxy.backgroundColor = UIColor.redColor()
        scrollProxy.frame = contentFrame
        scrollProxy.showsHorizontalScrollIndicator = false
        scrollProxy.showsVerticalScrollIndicator = false
        scrollProxy.bounces = false
        
        let user = User(name: "Toby", registered: NSDate(), profilePic: "toby1", flag: "USA")
        let blocks: [[Int?]?] = []
        let level = Level(name: "TestLevel", clearCount: 4, playCount: 8, stars: 2, creator: user, beaten: false, layout: blocks)

        
        let editor = LevelScrollView(reference: scrollProxy)
        self.editor = editor
        scrollProxy.addSubview(editor)
        
        let menu = UIView()
        menu.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1.0)
        view.addSubview(menu)
        menu.frame = CGRectMake(0,0, view.frame.width, menuHeight)
        let navBar = MenuCollectionView(frame: menu.frame, collectionViewLayout: UICollectionViewLayout(), reference: editor)
        view.addSubview(navBar)
        
        let minScale = CGFloat(1.0)
        scrollProxy.contentSize = self.editor!.contentSize
        scrollProxy.minimumZoomScale = minScale
        scrollProxy.zoomScale = minScale
        scrollProxy.maximumZoomScale = 20.0
        
        loadLevel(level)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("Scrolld")
    }
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        print("scrollViewWillBeginZooming")
    }
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        print("scrollViewDidEndZooming")
    }
    func scrollViewDidZoom(scrollView: UIScrollView) {
        print("scrollViewDidZoom")
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews[0]
    }
    
    func loadLevel(level: Level){
        self.view.addSubview(scrollProxy)
    }
    
}

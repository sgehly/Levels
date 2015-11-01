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
    let sc = UIScrollView()
    
    override func viewDidLoad() {
        self.view.addSubview(sc)
        
        let user = User(name: "Toby", registered: NSDate(), profilePic: "toby1", flag: "USA")
        let blocks: [[Int?]?] = []
        let level = Level(name: "TestLevel", clearCount: 4, playCount: 8, stars: 2, creator: user, beaten: false, layout: blocks)

        
        let editor = LevelScrollView(reference: sc)
        editor.frame = sc.frame
        self.editor = editor
        sc.addSubview(editor)
        
        let menu = UIView()
        menu.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1.0)
        self.view.addSubview(menu)
        menu.frame = CGRectMake(0,0, view.frame.width, menuHeight)
        let navBar = MenuCollectionView(frame: menu.frame, collectionViewLayout: UICollectionViewLayout(), reference: editor)
        menu.addSubview(navBar)
        
        sc.delegate = self
        sc.minimumZoomScale = 1.0
        sc.maximumZoomScale = 4.0
        sc.zoomScale = 2.0
        
        sc.frame = CGRectMake(0,menuHeight,self.view.frame.width*sc.zoomScale,(self.view.frame.height*sc.zoomScale)-menuHeight)

        sc.userInteractionEnabled = true
        sc.scrollEnabled = false
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
        print(sc.subviews)
        return sc.subviews[0]
    }
    
}

//
//  Snow.swift
//  Animation
//
//  Created by DaiFengyi on 16/1/20.
//  Copyright © 2016年 DaiFengyi. All rights reserved.
//

import UIKit
class Snow: UIViewController {
    var steps = 0
    var gameTimer : CADisplayLink?
    var snowImage = UIImage(named: "雪花")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        gameTimer = CADisplayLink(target: self, selector: "step")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        gameTimer = CADisplayLink(target: self, selector: "step")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        gameTimer?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
    }
    
    func step() {
        steps++
        
        if (steps % 6 == 0) {
            let imageView = UIImageView(image: snowImage)
            self.view.addSubview(imageView)
            
            let size = CGFloat(arc4random_uniform(UInt32(UIScreen.mainScreen().bounds.width))) / 320.0
            imageView.frame = CGRectMake(CGFloat(arc4random_uniform(UInt32(UIScreen.mainScreen().bounds.width))), 0, 10 * size + 10, 10 * size + 10);
            
            UIView.animateWithDuration(2, animations: { () -> Void in
                imageView.center = CGPointMake(CGFloat(arc4random_uniform(UInt32(UIScreen.mainScreen().bounds.width))), 460 + CGFloat(arc4random_uniform(100)))
                }, completion: { (finished: Bool) -> Void in
                    imageView.removeFromSuperview()
            })
        }
    }
}

//
//  ViewController.swift
//  UIMenuItemDemo
//
//  Created by DaiFengyi on 15/11/19.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.grayColor()
    }


    @IBAction func btnClick(sender: UIButton) {
        self.becomeFirstResponder()
        let mc = UIMenuController.sharedMenuController()
        mc.menuItems = [UIMenuItem(title: "abc", action:NSSelectorFromString("save")), UIMenuItem(title: "cddd", action: NSSelectorFromString("save"))]
        mc.setTargetRect(btn.frame, inView: self.view)
        mc.setMenuVisible(true, animated: true)
    }

    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        return true
    }
}


//
//  ViewController.swift
//  Navigation
//
//  Created by DaiFengyi on 16/1/19.
//  Copyright © 2016年 DaiFengyi. All rights reserved.
//

import UIKit

class NavigationTranslucent: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func switchClick(sender: UISwitch) {
        if (sender.on) {
            self.translucentBar()
        } else {
            self.opaqueBar()
        }
    }
    
    func opaqueBar() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Compact);
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "orange2x2"), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.clipsToBounds = false;
    }
    
    func translucentBar() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default);
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "orange2x2"), forBarMetrics: UIBarMetrics.Compact)
        self.navigationController?.navigationBar.clipsToBounds = true;
    }
}


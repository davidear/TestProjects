//
//  FirstViewController.swift
//  ViewWidget
//
//  Created by DaiFengyi on 16/1/21.
//  Copyright © 2016年 DaiFengyi. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let banner = FYScrollBanner(frame: CGRectMake(0, 0, 320, 200), index: 0)
        banner.imageList = [UIImage(named: "1-1")!, UIImage(named: "1-2")!, UIImage(named: "1-3")!, UIImage(named: "1-4")!]
        self.view.addSubview(banner)
    }
    

}


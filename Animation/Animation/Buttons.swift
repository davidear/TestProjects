//
//  Buttons.swift
//  Animation
//
//  Created by DaiFengyi on 16/1/20.
//  Copyright © 2016年 DaiFengyi. All rights reserved.
//

import UIKit

class Buttons: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 如果有需求要实现按住不改变图片，需要实时的设置highlight的图片，因为是点赞和取消点赞是不一样的
    @IBAction func zanClick(sender: UIButton) {
        sender.selected = !sender.selected
        sender.zanAnimation()
    }
    
    @IBAction func dadgeClick(sender: UIButton) {
        sender .setBadgeWithNumber(5)
    }
    
}

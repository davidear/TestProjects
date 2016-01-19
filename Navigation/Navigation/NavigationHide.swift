//
//  NavigationHide.swift
//  Navigation
//
//  Created by DaiFengyi on 16/1/19.
//  Copyright © 2016年 DaiFengyi. All rights reserved.
//

import UIKit

class NavigationHide: UIViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

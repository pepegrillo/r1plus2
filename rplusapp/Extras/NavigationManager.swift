//
//  NavigationManager.swift
//  rplusapp
//
//  Created by Josué López on 11/9/20.
//  Copyright © 2020 Josué López. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Change navigation colors
        self.navigationBar.tintColor = UIColor.white
        
    }

    //this method allow you to ask each controller for status bar style in navigation stack
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}

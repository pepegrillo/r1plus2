//
//  Application.swift
//  rplusapp
//
//  Created by Josué López on 11/9/20.
//  Copyright © 2020 Josué López. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static func topViewController() -> UIViewController? {
        return UIApplication.shared.windows.first!.rootViewController
    }
    
    static func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
    
    
}

//
//  AlertManager.swift
//  TributaSV
//
//  Created by Josué López on 11/9/20.
//  Copyright © 2020 Josué López. All rights reserved.UIApplication.shared.windows.first!.rootViewController
//

import Foundation
import UIKit

class AlertManager {
    
    static func showAlert(withMessage message: String, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title:"Aceptar", style: .default) { (action: UIAlertAction) in }
            alert.addAction(action)
            UIApplication.topViewController()?.present(alert, animated:true, completion:{})
            
        }
    }
    
    
}

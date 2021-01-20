//
//  UIViewController+Extensions.swift
//  rplusapp
//
//  Created by Josué López on 11/9/20.
//  Copyright © 2020 Josué López. All rights reserved.
//

import UIKit

struct GlobalVariables {
    static var showMessageSupportIos = true
}

extension UIViewController {
    
    
    func customRender() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        //navigationController?.navigationBar.isHidden = true
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        var keyboardFrame:CGRect = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        //guard view.frame.origin.y == 65 else { return }
        if #available(iOS 13.0, *) {
            let heightMax = (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) + (self.navigationController?.navigationBar.frame.height ?? 0.0) - keyboardFrame.height * 0.3

                view.frame.origin.y = heightMax
        } else {

            if (GlobalVariables.showMessageSupportIos == true) {
                // Fallback on earlier versions
                AlertManager.showAlert(withMessage: "Algunas funciones de esta pantalla requieren iOS 13 o superior, debes actualizar tu iOS para una mejor experiencia de usuario", title: "Error")

                GlobalVariables.showMessageSupportIos = false
            }

        }
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        if #available(iOS 13.0, *) {
            view.frame.origin.y = (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) + (self.navigationController?.navigationBar.frame.height ?? 0.0)
        } else {

            if (GlobalVariables.showMessageSupportIos == true) {
                // Fallback on earlier versions
                AlertManager.showAlert(withMessage: "Algunas funciones de esta pantalla requieren iOS 13 o superior, debes actualizar tu iOS para una mejor experiencia de usuario", title: "Error")

                GlobalVariables.showMessageSupportIos = false
            }
        }
        
    }
}

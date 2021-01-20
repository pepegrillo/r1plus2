//
//  TokenManager.swift
//  rplusapp
//
//  Created by Josué López on 11/9/20.
//  Copyright © 2020 Josué López. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import FBSDKLoginKit

class TokenManager {
    /*
    // Invalid Session
    static func invalidSession(onVC: UIViewController) {
        
        let alertController = UIAlertController(title: "Alerta", message: Constants.App.logoutMessage, preferredStyle: .alert)
        
        
        let openAction = UIAlertAction(title: "Cerrar", style: .destructive) { (action) in
            LogoutWS().postLogout(completion: { (dataResponse, error) in})
            AppData.sharedData.removeAllUserDefaults()
            onVC.dismiss(animated: true, completion: nil)
            
            
        }
        alertController.addAction(openAction)
        
        DispatchQueue.main.async{
            onVC.present(alertController, animated: true, completion: nil)
        }
        
    }
    */
    
    // Invalid Session
    static func invalidSession(onVC: UIViewController) {

        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alerta", message: Constants.App.logoutMessage, preferredStyle: .alert)
            
            
            let openAction = UIAlertAction(title: "Cerrar", style: .destructive) { (action) in
                LogoutWS().postLogout(completion: { (dataResponse, error) in})
                
                //Logout Google
                GIDSignIn.sharedInstance().signOut()
                
                //Logout Facebook
                let loginManager = LoginManager()
                loginManager.logOut()
                
                AppData.sharedData.removeAllUserDefaults()
                
                
            }
            alertController.addAction(openAction)
            
            //self.present(alertController, animated: true, completion: nil)
            UIApplication.topViewController()?.present(alertController, animated: true, completion: {
                // When the Dialog view has pop up on screen then just put this line of code when Dialog view has completed pop up.
                alertController.view.superview?.subviews[0].isUserInteractionEnabled = false
            })
        }
    }
    
}

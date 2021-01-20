//
//  AppDelegate.swift
//  rplusapp
//
//  Created by Josué López on 11/9/20.
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKCoreKit
import GoogleSignIn
import AuthenticationServices

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //scroll forms
        IQKeyboardManager.shared.enable = true
        
        // MARK: Facebook
        //Facebook SDK
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        // MARK: Google
        //google Signin
        // 1
        GIDSignIn.sharedInstance().clientID = "68005560661-b8503gkgjtmulei0dg7foge1i0o31kcr.apps.googleusercontent.com"
        // 2
        GIDSignIn.sharedInstance().delegate = self
        // 3
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        // MARK: Apple
        // Apple ID Signin
        
        if #available(iOS 13.0, *) {
            signWithApple()
        } 
        
        return true
    }
    
    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication:
                options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation:
                options[UIApplication.OpenURLOptionsKey.annotation]
        )
        
        GIDSignIn.sharedInstance().handle(url)
        
        return true
        
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

extension AppDelegate {
    
    @available(iOS 13.0, *)
    func signWithApple(){
        
        // MARK: Apple
        // Apple ID Signin
        let userId = UserDefaults.standard.string(forKey: "Apple_ID") ?? ""
        print("AUthorized Apple \(userId)")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
        appleIDProvider.getCredentialState(forUserID: userId) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                
//                let authorization: ASAuthorization
                
                
                print("AUthorized Apple \(UserDefaults.standard.string(forKey: "userEmail") ?? "")")
                break // The Apple ID credential is valid.
            case .revoked, .notFound:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                DispatchQueue.main.async {
//                    let vc = self.window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                    self.window?.rootViewController?.navigationController?.pushViewController(vc, animated: true)
                    print("REVOCADO Debo enviar a la pantalla de login APPLE")
                }
            default:
                break
            }
        }
    }
}

// MARK: Google Signin
extension AppDelegate: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        // Check for sign in error
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }

        // Post notification after user successfully sign in
        NotificationCenter.default.post(name: .signInGoogleCompleted, object: nil)
    }
}

// MARK:- Notification names
extension Notification.Name {
    
    /// Notification when user successfully sign in using Google
    static var signInGoogleCompleted: Notification.Name {
        return .init(rawValue: #function)
    }
}


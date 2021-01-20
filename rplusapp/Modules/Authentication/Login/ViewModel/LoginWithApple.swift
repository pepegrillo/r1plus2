//
//  LoginWithApple.swift
//  rplusapp
//
//  Created by Josué López on 12/11/20.
//

import UIKit
import Foundation
import AuthenticationServices

enum AppleLoginFailError : Int {
    case revoked = 0
    case notFound
    case error
}

@available(iOS 13.0, *)
class LoginWithApple : NSObject {
    
    var successClosure : (()->Void)?
    var successClosureWith : ((String, PersonNameComponents?, String?)->Void)? = nil
    var failureClosure : ((AppleLoginFailError)->Void)? = nil
    var failureClosureWith : ((AppleLoginFailError, Error)->Void)? = nil

    @objc func handleAuthorizationAppleIDAction() {
        
        let requestAppleProviderID = ASAuthorizationAppleIDProvider().createRequest()
        requestAppleProviderID.requestedScopes = [.fullName, .email] // optional, add if we need any of this info
        let requestPasswrdProviderID = ASAuthorizationPasswordProvider().createRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [requestAppleProviderID, requestPasswrdProviderID]) // which ever will be found, user can continue with that
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
  
    func checkAutoLogin() {
        let userId = UserDefaults.standard.string(forKey: "userId") ?? ""
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userId) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("Auto login successful")
                //resume normal app flow
                break
            case .revoked, .notFound:
                print("Auto login not successful")
                //show login screen or you also invoke handleAuthorizationAppleIDAction
                break
            default:
                
                break
            }
        }
    }
}

@available(iOS 13.0, *)
extension LoginWithApple : ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
            
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            UserDefaults.standard.set(userIdentifier, forKey: "userId") // For purpose of this demo saving this UserId in UserDefaults. We will use this user Id for checking its validity for Auto Login functionality
            if let closure = self.successClosure {
                closure()
            }
            if let closure = self.successClosureWith {
                closure(userIdentifier, fullName, email)
            }
            
            break
            
        case let passwordCredential as ASPasswordCredential:
            
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("username \(username)   password \(password)") // use this information to verify the account from server and resume normal app flow
            
            break
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        if let closure = self.failureClosureWith {
            closure(.error, error)
        }
    }
}

@available(iOS 13.0,*)
extension LoginWithApple: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first! // return the window on which you want the Auth UI to be displayed
    }
}

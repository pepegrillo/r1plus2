//
//  LoginRplusWS.swift
//  rplusapp
//
//  Created by Josué López on 11/23/20.
//

import UIKit

struct LoginRplusWS {
    
    func postLoginRplus(body: [String],completion: @escaping (LoginRplus?, _ error: Error?)->()) {
        let body: [String: Any] = [
            "username": body[0],
            "password": body[1],
            "login_type": body[2],
            "appleIDCredential_user": body[3],
            "appleIDCredential_identityToken": body[4],
            "google_userID": body[5],
            "google_authentication_idToken": body[6],
            "fb_profile_userID": body[7],
            "fb_profile_access_token": body[8]
        ]
        print("LOGINRPLUS \(body)")
        let url = Constants.WS.postLoginRplus
        RequestManager.sharedService.requestAPI(url: url, parameter: body as [String : Any], httpMethodType: .POST) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            completion(LoginRplus(attributes: data), nil)
        }
    }
}


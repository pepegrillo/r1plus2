//
//  RegistroWS.swift
//  rplusapp
//
//  Created by Josué López on 11/24/20.
//

import UIKit

struct RegistroWS {
    
    func postRegistro(body: [String],completion: @escaping (Registro?, _ error: Error?)->()) {
//        let body: [String: Any] = [
//            "name": body[0],
//            "last_name": body[1],
//            "email": body[2],
//            "password": body[3],
//            "c_password": body[4],
//            "phone": body[5],
//            "home_phone": body[6],
//            "token_push": body[7],
//            "id_dispositivo": body[8],
//            "id_rol": body[9],
//            "type_register": body[10],
//            "appleIDCredential_user": body[11],
//            "appleIDCredential_identityToken": body[12],
//            "appleIDCredential_authorizationCode": body[13],
//            "appleIDCredential_authorizedScopes": body[14],
//            "appleIDCredential_state": body[15],
//            "google_userID": body[16],
//            "google_authentication_idToken": body[17],
//            "fb_profile_userID": body[18],
//            "fb_profile_access_token": body[19],
//            "avatar": body[20]
//        ]
        
//        let image64 = UserDefaults.standard.string(forKey: Constants.App.image64Registro)
        
        let body: [String: Any] = [
            "name": "\(body[0])",
            "last_name": "\(body[1])",
            "email": "\(body[2])",
            "password": "\(body[3])",
            "c_password": "\(body[4])",
            "phone": "\(body[5])",
            "home_phone": "\(body[6])",
            "token_push": "\(body[7])",
            "id_dispositivo": "\(body[8])",
            "id_rol": "\(body[9])",
            "type_register": "\(body[10])",
            "appleIDCredential_user": "\(body[11])",
            "appleIDCredential_identityToken": "\(body[12])",
            "appleIDCredential_authorizationCode": "\(body[13])",
            "appleIDCredential_authorizedScopes": "\(body[14])",
            "appleIDCredential_state": "\(body[15])",
            "google_userID": "\(body[16])",
            "google_authentication_idToken": "\(body[17])",
            "fb_profile_userID": "\(body[18])",
            "fb_profile_access_token": "\(body[19])",
            "avatar": "\(body[20])"
        ]
        print(body)
        let url = Constants.WS.postRegistro
        RequestManager.sharedService.requestAPI(url: url, parameter: body as [String : Any], httpMethodType: .POST) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            completion(Registro(attributes: data), nil)
        }
    }
}

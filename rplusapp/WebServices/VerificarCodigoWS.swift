//
//  VerificarCodigoWS.swift
//  rplusapp
//
//  Created by Josué López on 11/24/20.
//

import UIKit

struct VerificarCodigoWS {
    
    func postVerificarCodigo(body: [String],completion: @escaping (LoginRplus?, _ error: Error?)->()) {
        let body: [String: Any] = [
            "code": body[0]
        ]
        
        
        print(body)
        let url = Constants.WS.postVerificarCodigo
        RequestManager.sharedService.requestAPI(url: url, parameter: body as [String : Any], httpMethodType: .POST) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            completion(LoginRplus(attributes: data), nil)
        }
    }
    
    //PasswordRecovery With Password
    func postVerificarCodigoWithPassword(body: [String],completion: @escaping (GeneralModel?, _ error: Error?)->()) {
        let body: [String: Any] = [
            "codigo": body[0],
            "password": body[1]
        ]
        
        
        print(body)
        let url = Constants.WS.postVerificarCodigoWithPassword
        RequestManager.sharedService.requestAPI(url: url, parameter: body as [String : Any], httpMethodType: .POST) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            completion(GeneralModel(attributes: data), nil)
        }
    }
}

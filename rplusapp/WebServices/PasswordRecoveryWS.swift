//
//  PasswordRecoveryWS.swift
//  rplusapp
//
//  Created by Josué López on 12/18/20.
//

import UIKit

struct PasswordRecoveryWS {
    
    func postPasswordRecovery(body: [String],completion: @escaping (GeneralModel?, _ error: Error?)->()) {
        let body: [String: Any] = [
            "phone": body[0]
        ]
        
        
        print(body)
        let url = Constants.WS.postPasswordRecovery
        RequestManager.sharedService.requestAPI(url: url, parameter: body as [String : Any], httpMethodType: .POST) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            completion(GeneralModel(attributes: data), nil)
        }
    }
}

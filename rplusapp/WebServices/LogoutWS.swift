//
//  LogoutWS.swift
//  rplusapp
//
//  Created by Josué López on 11/23/20.
//

import UIKit

struct LogoutWS {
    
    func postLogout(completion: @escaping ([String:Any]?, _ error: Error?)->()) {
       
        let url = Constants.WS.postLogout
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .POST) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            print("LOGOUT \(data)")
            
            completion(data, nil)
        }
    }
}


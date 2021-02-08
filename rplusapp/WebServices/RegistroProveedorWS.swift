//
//  RegistroProveedorWS.swift
//  rplusapp
//
//  Created by Josué López on 11/26/20.
//

import UIKit

struct RegistroProveedorWS {
    
    func postRegistroProveedor(body: [String],completion: @escaping (GeneralModel?, _ error: Error?)->()) {
        let body: [String: Any] = [
            "empresa": body[0],
            "date": body[1],
            "hour": body[2],
            "place_type": body[3],
            "id_lugar": body[4]
        ]
        
        
        print(body)
        let url = Constants.WS.postRegistroProveedor
        RequestManager.sharedService.requestAPI(url: url, parameter: body as [String : Any], httpMethodType: .POST) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            completion(GeneralModel(attributes: data), nil)
        }
    }
}

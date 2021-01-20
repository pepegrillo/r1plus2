//
//  AmenidadesWS.swift
//  rplusapp
//
//  Created by Josué López on 12/8/20.
//

import UIKit

struct AmenidadesWS {
    
    func postAmenidades(body: [String],completion: @escaping (GeneralModel?, _ error: Error?)->()) {
        let body: [String: Any] = [
            "hora": body[2],
            "fecha": body[1],
            "id_area": body[0]
        ]
        
        
        print(body)
        let url = Constants.WS.postAmenidades
        RequestManager.sharedService.requestAPI(url: url, parameter: body as [String : Any], httpMethodType: .POST) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            completion(GeneralModel(attributes: data), nil)
        }
    }
}

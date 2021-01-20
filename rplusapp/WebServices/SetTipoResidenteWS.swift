//
//  SetTipoResidenteWS.swift
//  rplusapp
//
//  Created by Josué López on 11/25/20.
//

import UIKit

struct SetTipoResidenteWS {
    
    func postSetTipoResidente(body: [String], completion: @escaping (GeneralModel?, _ error: Error?)->()) {
       
        let body: [String: Any] = [
            "id_residencial": body[0],
            "id_tipo_residente": body[1]
        ]
        print("\(body)")
        
        let url = Constants.WS.postSetTipoResidente
        RequestManager.sharedService.requestAPI(url: url, parameter: body as [String : Any], httpMethodType: .POST) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            completion(GeneralModel(attributes: data), nil)
        }
    }
}

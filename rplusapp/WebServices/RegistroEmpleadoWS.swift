//
//  RegistroEmpleadoWS.swift
//  rplusapp
//
//  Created by Josué López on 11/26/20.
//

import UIKit

struct RegistroEmpleadoWS {
    
    func postRegistroEmpleado(body: [String],completion: @escaping (GeneralModel?, _ error: Error?)->()) {
        let body: [String: Any] = [
            "name": body[0],
            "last_name": body[1],
            "phone": body[2],
            "document_number": body[3],
            "img_dui_frente": body[4],
            "img_dui_reverso": body[5]
        ]
        
        
        print(body)
        let url = Constants.WS.postRegistroEmpleado
        RequestManager.sharedService.requestAPI(url: url, parameter: body as [String : Any], httpMethodType: .POST) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            completion(GeneralModel(attributes: data), nil)
        }
    }
}

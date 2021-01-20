//
//  RegistroVisitaWS.swift
//  rplusapp
//
//  Created by Josué López on 11/27/20.
//

import UIKit

struct RegistroVisitaWS {
    
    func postRegistroVisita(body: [String],completion: @escaping (GeneralModel?, _ error: Error?)->()) {
        let body: [String: Any] = [
            "tipo_visita": body[0],
            "name": body[1],
            "last_name": body[2],
            "email": body[3],
            "date": body[4],
            "hour": body[5],
            "phone": body[6],
            "place_type": body[7],
            "id_lugar": body[8],
            "type_document": body[9],
            "document_number": body[10],
            "vehicle_plate": body[11]
        ]
        
        
        print(body)
        let url = Constants.WS.postRegistroVisita
        RequestManager.sharedService.requestAPI(url: url, parameter: body as [String : Any], httpMethodType: .POST) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            completion(GeneralModel(attributes: data), nil)
        }
    }
}

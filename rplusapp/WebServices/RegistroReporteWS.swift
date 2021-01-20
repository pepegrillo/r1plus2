//
//  RegistroReporteWS.swift
//  rplusapp
//
//  Created by Josué López on 12/3/20.
//

import UIKit

struct RegistroReporteWS {
    
    func postRegistroReporte(body: [String], array: Array<Any>,completion: @escaping (GeneralModel?, _ error: Error?)->()) {
        let body: [String: Any] = [
            "id_alerta": body[0],
            "description": body[1],
            "lat": body[2],
            "lon": body[3],
            "fotos": array
        ]
        
        
        
        print("------> \(body)")
        let url = Constants.WS.postRegistroReporte
        RequestManager.sharedService.requestAPI(url: url, parameter: body as [String : Any], httpMethodType: .POST) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            completion(GeneralModel(attributes: data), nil)
        }
    }
}

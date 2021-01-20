//
//  VisitaFrecuenteWS.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

import UIKit

struct VisitaFrecuenteWS {
    
    func getVisitaFrecuenteListByLimit(idTypeURL: Int, completion: @escaping (VisitaFrecuente?,_ error: Error?)->()) {
        
        var url = ""
        if (idTypeURL == 1) {
            url = Constants.WS.getVisitaFrecuenteAll
        } else {
            url = Constants.WS.getVisitaFrecuente
        }
        
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(VisitaFrecuente(attributes: data), nil)
        }
    }
    
}

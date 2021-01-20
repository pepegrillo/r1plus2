//
//  PasesAsignadosWS.swift
//  rplusapp
//
//  Created by Josué López on 12/4/20.
//

import UIKit

struct PasesAsignadosWS {
    
    func getPasesAsignadosList(completion: @escaping (PaseAsignado?,_ error: Error?)->()) {
        
        let url = Constants.WS.getPasesAsignados
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(PaseAsignado(attributes: data), nil)
        }
    }
    
}

//
//  TipoResindeteWS.swift
//  rplusapp
//
//  Created by Josué López on 11/25/20.
//

import UIKit

struct TipoResidenteWS {
    
    func getTipoResidenteList(idResidencial: String, completion: @escaping (TipoResidente?,_ error: Error?)->()) {
        
        let url = Constants.WS.getTipoResidente + idResidencial
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(TipoResidente(attributes: data), nil)
        }
    }
    
}

//
//  MascotasWS.swift
//  rplusapp
//
//  Created by Josué López on 11/19/20.
//

import UIKit

struct MascotasWS {
    
    func getMascotaList(completion: @escaping (Mascota?,_ error: Error?)->()) {
        
        let url = Constants.WS.getMascotas
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(Mascota(attributes: data), nil)
        }
    }
    
}

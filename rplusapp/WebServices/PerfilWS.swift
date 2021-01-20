//
//  PerfilWS.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

import UIKit

struct PerfilWS {
    
    func getPerfil(completion: @escaping (Perfil?,_ error: Error?)->()) {
        
        let url = Constants.WS.getPerfil
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(Perfil(attributes: data), nil)
        }
    }
    
}

//
//  TipoUsuarioWS.swift
//  rplusapp
//
//  Created by Josué López on 11/24/20.
//

import UIKit

struct TipoUsuarioWS {
    
    func getTipoUsuarioList(completion: @escaping (TipoUsuario?,_ error: Error?)->()) {
        
        let url = Constants.WS.getTipoUsuario
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(TipoUsuario(attributes: data), nil)
        }
    }
    
}

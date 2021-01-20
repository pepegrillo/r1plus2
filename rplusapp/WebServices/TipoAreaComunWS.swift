//
//  TipoAreaComunWS.swift
//  rplusapp
//
//  Created by Josué López on 11/26/20.
//

import UIKit

struct TipoAreaComunWS {
    
    func getTipoAreaComunList(completion: @escaping (TipoAreaComun?,_ error: Error?)->()) {
        
        let url = Constants.WS.getAreaComun
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(TipoAreaComun(attributes: data), nil)
        }
    }
    
}

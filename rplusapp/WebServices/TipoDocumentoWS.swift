//
//  TipoDocumentoWS.swift
//  rplusapp
//
//  Created by Josué López on 11/27/20.
//

import UIKit

struct TipoDocumentoWS {
    
    func getTipoDocumentoList(completion: @escaping (TipoDocumento?,_ error: Error?)->()) {
        
        let url = Constants.WS.getTipoDocumento
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(TipoDocumento(attributes: data), nil)
        }
    }
    
}

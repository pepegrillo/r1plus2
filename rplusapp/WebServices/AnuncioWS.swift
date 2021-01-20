//
//  AnuncioWS.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

import UIKit

struct AnuncioWS {
    
    func getAnuncioList(completion: @escaping (Anuncio?,_ error: Error?)->()) {
        
        let url = Constants.WS.getAnuncio
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(Anuncio(attributes: data), nil)
        }
    }
    
}

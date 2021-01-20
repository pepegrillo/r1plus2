//
//  ResidencialWS.swift
//  rplusapp
//
//  Created by Josué López on 11/17/20.
//

import UIKit

struct ResidencialWS {
    
    func getResidencialList(completion: @escaping (Residencial?,_ error: Error?)->()) {
        
        let url = Constants.WS.getResidencial
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(Residencial(attributes: data), nil)
        }
    }
    
}

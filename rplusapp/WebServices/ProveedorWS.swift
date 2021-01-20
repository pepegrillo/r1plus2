//
//  ProveedorWS.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

import UIKit

struct ProveedorWS {
    
    func getProveedorListByLimit(idTypeURL: Int, completion: @escaping (Proveedor?,_ error: Error?)->()) {
        
        var url = ""
        if (idTypeURL == 1) {
            url = Constants.WS.getProveedorAll
        } else {
            url = Constants.WS.getProveedor
        }
        
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(Proveedor(attributes: data), nil)
        }
    }
    
}

//
//  EmpresaProveedorWS.swift
//  rplusapp
//
//  Created by Josué López on 11/26/20.
//

import UIKit

struct EmpresaProveedorWS {
    
    func getEmpresaProveedorList(completion: @escaping (EmpresaProveedor?,_ error: Error?)->()) {
        
        let url = Constants.WS.getEmpresaProveedor
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(EmpresaProveedor(attributes: data), nil)
        }
    }
    
}

//
//  EmpleadoDetalleWS.swift
//  rplusapp
//
//  Created by Josué López on 12/4/20.
//

import UIKit

struct EmpleadoDetalleWS {
    
    func getEmpleadoDetalle(idEmpleadoDetalle: Int, completion: @escaping (EmpleadoDetalle?,_ error: Error?)->()) {
        
        let url = Constants.WS.getEmpleadoDetalle + "\(idEmpleadoDetalle)"
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(EmpleadoDetalle(attributes: data), nil)
        }
    }
    
}

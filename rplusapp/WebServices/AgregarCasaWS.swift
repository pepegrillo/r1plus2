//
//  AgregarCasaWS.swift
//  rplusapp
//
//  Created by Josué López on 11/25/20.
//

import UIKit

struct AgregarCasaWS {
    
    // get tipo sector
    func getSectorList(completion: @escaping (Sector?,_ error: Error?)->()) {
        
        let url = Constants.WS.getTipoSector
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(Sector(attributes: data), nil)
        }
    }
    
    // get tipo ubicacion segun sector
    func getUbicacionPorSector(idSector: String, completion: @escaping (Ubicacion?,_ error: Error?)->()) {
        
        let url = Constants.WS.getUbicacionPorSector + idSector
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(Ubicacion(attributes: data), nil)
        }
    }
    
    // get tipo vivienda segun ubicacion
    func getViviendaPorUbicacion(idUbicacion: String, completion: @escaping (Vivienda?,_ error: Error?)->()) {
        
        let url = Constants.WS.getViviendaPorUbicacion + idUbicacion
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(Vivienda(attributes: data), nil)
        }
    }
    
    // POST PARA registrar la configuracin de agregar csa
    func postAgregarCasa(body: [String], completion: @escaping (GeneralModel?, _ error: Error?)->()) {
       
        let body: [String: Any] = [
            "tipo_ocupacion": body[0],
            "vivienda": body[1]
        ]
        print("\(body)")
        
        let url = Constants.WS.postAgregarCasa
        RequestManager.sharedService.requestAPI(url: url, parameter: body as [String : Any], httpMethodType: .POST) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            completion(GeneralModel(attributes: data), nil)
        }
    }
    
}

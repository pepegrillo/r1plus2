//
//  BeneficioRestriccionWS.swift
//  rplusapp
//
//  Created by Josué López on 12/2/20.
//

struct BeneficioRestriccionWS {
    
    func getBeneficioList(completion: @escaping (Beneficio?,_ error: Error?)->()) {
        
        let url = Constants.WS.getBeneficio
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(Beneficio(attributes: data), nil)
        }
    }
    
    func getRestriccionList(completion: @escaping (Restriccion?,_ error: Error?)->()) {
        
        let url = Constants.WS.getRestriccion
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(Restriccion(attributes: data), nil)
        }
    }
    
}

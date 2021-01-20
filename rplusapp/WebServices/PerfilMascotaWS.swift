//
//  PerfilMascotaWS.swift
//  rplusapp
//
//  Created by Josué López on 12/1/20.
//

struct PerfilMascotaWS {
    
    func getPerfilMascota(idMascota: Int, completion: @escaping (PerfilMascota?,_ error: Error?)->()) {
        
        let url = Constants.WS.getPerfilMascota + "\(idMascota)"
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(PerfilMascota(attributes: data), nil)
        }
    }
    
}

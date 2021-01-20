//
//  TipoMascotaWS.swift
//  rplusapp
//
//  Created by Josué López on 12/1/20.
//

struct TipoMascotaWS {
    
    func getTipoMascotaList(completion: @escaping (TipoMascota?,_ error: Error?)->()) {
        
        let url = Constants.WS.getTipoMascota
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(TipoMascota(attributes: data), nil)
        }
    }
    
}

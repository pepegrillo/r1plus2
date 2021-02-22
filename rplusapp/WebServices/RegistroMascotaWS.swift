//
//  RegistroMascotaWS.swift
//  rplusapp
//
//  Created by Josué López on 12/1/20.
//

struct RegistroMascotaWS {
    
    func postRegistroMascota(body: [String],completion: @escaping (GeneralModel?, _ error: Error?)->()) {
        
        let body: [String: Any] = [
            "name": body[0],
            "breed": body[2],
            "description": body[3],
            "id_tipo_mascota": body[1],
            "photo_pet": body[4],
            "photo_card": body[5]
        ]
        
        print(body)
        let url = Constants.WS.postRegistroMascota
        RequestManager.sharedService.requestAPI(url: url, parameter: body as [String : Any], httpMethodType: .POST) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            completion(GeneralModel(attributes: data), nil)
        }
    }
}

//
//  ContactosVerificadosWS.swift
//  rplusapp
//
//  Created by Josue Lopez on 1/25/21.
//

struct ContactosVerificadosWS {
    
    func postContactosVerificados(body: [String],completion: @escaping (ContactosVerificadosWs?, _ error: Error?)->()) {
        let body: [String: Any] = [
            "contactos": body
        ]
        print(body)
        let url = Constants.WS.postContacto
        RequestManager.sharedService.requestAPI(url: url, parameter: body as [String : Any], httpMethodType: .POST) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            completion(ContactosVerificadosWs(attributes: data), nil)
        }
    }
    
}

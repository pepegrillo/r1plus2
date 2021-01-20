//
//  AlertaWS.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

struct AlertaWS {
    
    func getAlertaList(completion: @escaping (Alerta?,_ error: Error?)->()) {
        
        let url = Constants.WS.getAlerta
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(Alerta(attributes: data), nil)
        }
    }
    
}

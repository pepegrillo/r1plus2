//
//  HistorialPagoWS.swift
//  rplusapp
//
//  Created by Josué López on 11/30/20.
//

struct HistorialPagoWS {
    
    func getHistorialPagoList(idTelefono: String, completion: @escaping (HistorialPago?,_ error: Error?)->()) {
        
        let url = Constants.WS.getHistorialPago + idTelefono
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(HistorialPago(attributes: data), nil)
        }
    }
    
}

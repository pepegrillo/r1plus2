//
//  ReporteWS.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

struct ReporteWS {
    
    func getReporteList(completion: @escaping (Reporte?,_ error: Error?)->()) {
        
        let url = Constants.WS.getReporte
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(Reporte(attributes: data), nil)
        }
    }
    
    func getReporteDetalle(idReporte: Int, completion: @escaping (ReporteDetalle?,_ error: Error?)->()) {
        
        let url = Constants.WS.getReporteDetalle + "\(idReporte)"
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(ReporteDetalle(attributes: data), nil)
        }
    }
}

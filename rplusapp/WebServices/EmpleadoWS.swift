//
//  EmpleadoWS.swift
//  rplusapp
//
//  Created by Josué López on 12/1/20.
//

struct EmpleadoWS {
    
    func getEmpleadoListByLimit(idTypeURL: Int, completion: @escaping (Empleado?,_ error: Error?)->()) {
        
        var url = ""
        if (idTypeURL == 1) {
            url = Constants.WS.getEmpleadoAll
        } else {
            url = Constants.WS.getEmpleado
        }
        
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(Empleado(attributes: data), nil)
        }
    }
    
}

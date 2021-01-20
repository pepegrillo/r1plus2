//
//  DirectorioWS.swift
//  rplusapp
//
//  Created by Josué López on 11/19/20.
//

struct DirectorioWS {
    
    func getDirectorioList(completion: @escaping (Directorio?,_ error: Error?)->()) {
        
        let url = Constants.WS.getDirectorio
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(Directorio(attributes: data), nil)
        }
    }
    
}

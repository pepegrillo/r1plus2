//
//  DeleteWS.swift
//  rplusapp
//
//  Created by Rene Borja on 1/16/21.
//

import UIKit

struct DeleteWS {
    
    func deleteElement(paramId: Int, paramUrl: String, completion: @escaping (GeneralModel?,_ error: Error?)->()) {
        
        let url = "\(Constants.WS.baseURLAPI)\(Constants.WS.complementURL)\(paramUrl)/\(paramId)"
        print(url)
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .DELETE) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(GeneralModel(attributes: data), nil)
        }
    }
    
}

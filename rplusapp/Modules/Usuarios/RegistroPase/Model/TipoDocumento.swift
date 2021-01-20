//
//  TipoDocumento.swift
//  rplusapp
//
//  Created by Josué López on 11/27/20.
//

import UIKit

// MARK: - TipoDocumento
struct TipoDocumento: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataTipoDocumento]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataTipoDocumento]()
            datas.forEach({
                model.append(DataTipoDocumento(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataTipoDocumento
struct DataTipoDocumento: Codable {
    var id: Int?
    var name: String?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.name = attributes["name"] as? String
    }
}

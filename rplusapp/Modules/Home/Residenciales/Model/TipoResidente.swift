//
//  TipoResidente.swift
//  rplusapp
//
//  Created by Josué López on 11/25/20.
//

import UIKit

// MARK: - TipoResidente
struct TipoResidente: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataTipoResidente]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataTipoResidente]()
            datas.forEach({
                model.append(DataTipoResidente(attributes: $0))
            })
            self.data = model
        }
    }
}

// TipoResidente Model
struct DataTipoResidente: Codable {
    
    var id: Int?
    var name: String?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.name = attributes["name"] as? String
    }
}



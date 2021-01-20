//
//  Registro.swift
//  rplusapp
//
//  Created by Josué López on 11/24/20.
//

import UIKit

// MARK: - Registro
struct Registro: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataRegistro]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataRegistro]()
            datas.forEach({
                model.append(DataRegistro(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataRegistro
struct DataRegistro: Codable {
    var id, residential: Int?
    var name, lastName: String?

    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.name = attributes["name"] as? String
        self.lastName = attributes["last_name"] as? String
        self.residential = attributes["residential"] as? Int
    }
}

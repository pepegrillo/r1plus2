//
//  Directorio.swift
//  rplusapp
//
//  Created by Josué López on 11/19/20.
//

import UIKit

// MARK: - Directorio
struct Directorio: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataDirectorio]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataDirectorio]()
            datas.forEach({
                model.append(DataDirectorio(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataDirectorio
struct DataDirectorio: Codable {
    var id: Int?
    var name, phone, photo: String?
    var tipo: Int?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.name = attributes["name"] as? String
        self.phone = attributes["phone"] as? String
        self.tipo = attributes["tipo"] as? Int
        self.photo = attributes["photo"] as? String
        
    }
}

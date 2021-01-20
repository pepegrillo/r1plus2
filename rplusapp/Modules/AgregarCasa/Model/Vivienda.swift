//
//  Vivienda.swift
//  rplusapp
//
//  Created by Josué López on 11/25/20.
//

import UIKit

// MARK: - Vivienda
struct Vivienda: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataVivienda]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataVivienda]()
            datas.forEach({
                model.append(DataVivienda(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataVivienda
struct DataVivienda: Codable {
    var id: Int?
    var vivienda: String?
    var status, idResidencial, idUbicacion: Int?
    var createdAt, updatedAt: String?

    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.vivienda = attributes["vivienda"] as? String
        self.status = attributes["status"] as? Int
        self.idResidencial = attributes["id_residencial"] as? Int
        self.idUbicacion = attributes["id_ubicacion"] as? Int
        self.createdAt = attributes["created_at"] as? String
        self.updatedAt = attributes["updated_at"] as? String
    }
}

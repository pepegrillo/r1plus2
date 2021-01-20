//
//  Ubicacion.swift
//  rplusapp
//
//  Created by Josué López on 11/25/20.
//

import UIKit

// MARK: - Ubicacion
struct Ubicacion: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataUbicacion]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataUbicacion]()
            datas.forEach({
                model.append(DataUbicacion(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataUbicacion
struct DataUbicacion: Codable {
    var id: Int?
    var name, description: String?
    var status, idTipoSector: Int?
    var createdAt, updatedAt: String?

    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.name = attributes["name"] as? String
        self.description = attributes["description"] as? String
        self.status = attributes["status"] as? Int
        self.idTipoSector = attributes["id_tipo_sector"] as? Int
        self.createdAt = attributes["created_at"] as? String
        self.updatedAt = attributes["updated_at"] as? String
    }
}

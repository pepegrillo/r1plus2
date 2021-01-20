//
//  Sector.swift
//  rplusapp
//
//  Created by Josué López on 11/25/20.
//

import UIKit

// MARK: - Sector
struct Sector: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataSector]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataSector]()
            datas.forEach({
                model.append(DataSector(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataSector
struct DataSector: Codable {
    var id: Int?
    var name, description: String?
    var status, idResidencial: Int?
    var createdAt, updatedAt: String?

    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.name = attributes["name"] as? String
        self.description = attributes["description"] as? String
        self.status = attributes["status"] as? Int
        self.idResidencial = attributes["id_residencial"] as? Int
        self.createdAt = attributes["created_at"] as? String
        self.updatedAt = attributes["updated_at"] as? String
    }
}

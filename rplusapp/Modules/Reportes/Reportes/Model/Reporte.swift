//
//  Reporte.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

import UIKit

// MARK: - Perfil
struct Reporte: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataReporte]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataReporte]()
            datas.forEach({
                model.append(DataReporte(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataReporte
struct DataReporte: Codable {
    var idReporte: Int?
    var createdAt, imgAlerta, alerta, estado: String?
    
    init(attributes: [String: Any]) {
        self.idReporte = attributes["id_reporte"] as? Int
        self.createdAt = attributes["created_at"] as? String
        self.imgAlerta = attributes["img_alerta"] as? String
        self.alerta = attributes["alerta"] as? String
        self.estado = attributes["estado"] as? String
        
    }
}

//
//  VisitaFrecuenteDetalle.swift
//  rplusapp
//
//  Created by Desarrollo on 2/17/21.
//

import UIKit

// MARK: - Perfil
struct VisitaFrecuenteDetalle: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataVisitaFrecuenteDetalle]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataVisitaFrecuenteDetalle]()
            datas.forEach({
                model.append(DataVisitaFrecuenteDetalle(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataVisitaFrecuente
struct DataVisitaFrecuenteDetalle: Codable {
    var id: Int?
    var code, name, lastName, email, date, hour, phone: String?
    var documentNumber, vehiclePlate: String?
    var idLugar: Int?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.code = attributes["code"] as? String
        self.name = attributes["name"] as? String
        self.lastName = attributes["last_name"] as? String
        self.email = attributes["email"] as? String
        self.date = attributes["date"] as? String
        self.hour = attributes["hour"] as? String
        self.phone = attributes["phone"] as? String
        self.documentNumber = attributes["document_number"] as? String
        self.vehiclePlate = attributes["vehicle_plate"] as? String
        self.idLugar = attributes["id_lugar"] as? Int
        
    }
}

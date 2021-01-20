//
//  VisitaFrecuente.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

import UIKit

// MARK: - Perfil
struct VisitaFrecuente: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataVisitaFrecuente]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataVisitaFrecuente]()
            datas.forEach({
                model.append(DataVisitaFrecuente(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataVisitaFrecuente
struct DataVisitaFrecuente: Codable {
    var id, idUser: Int?
    var name, lastName: String?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.idUser = attributes["id_user"] as? Int
        self.name = attributes["name"] as? String
        self.lastName = attributes["last_name"] as? String
        
    }
}

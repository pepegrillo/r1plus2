//
//  HistorialPago.swift
//  rplusapp
//
//  Created by Josué López on 11/30/20.
//

import UIKit

// MARK: - HistorialPago
struct HistorialPago: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataHistorialPago]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataHistorialPago]()
            datas.forEach({
                model.append(DataHistorialPago(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataHistorialPago
struct DataHistorialPago: Codable {
    var id: Int?
    var codigo: String?
    var link: String?
    var correo: String?
    var monto: Int?
    var telefono: String?
    var dui, concepto: String?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.codigo = attributes["codigo"] as? String
        self.link = attributes["link"] as? String
        self.correo = attributes["correo"] as? String
        self.monto = attributes["monto"] as? Int
        self.dui = attributes["dui"] as? String
        self.concepto = attributes["concepto"] as? String
        self.telefono = attributes["telefono"] as? String
        
    }
}

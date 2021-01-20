//
//  EmpleadoDetalle.swift
//  rplusapp
//
//  Created by Josué López on 12/4/20.
//

import UIKit

// MARK: - EmpleadoDetalle
struct EmpleadoDetalle: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataEmpleadoDetalle]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataEmpleadoDetalle]()
            datas.forEach({
                model.append(DataEmpleadoDetalle(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataEmpleadoDetalle
struct DataEmpleadoDetalle: Codable {
    var id: Int?
    var nombre: String?
    var telefono: [DataEmpleadoDetalleTelefono]?
    var duiFrente: String?
    var duiReverso: String?
    var residencial, tipoResidente: String?
    var tieneResidencial: Int?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.nombre = attributes["Nombre"] as? String
        if let datas = attributes["telefono"] as? [[String:Any]] {
            var model = [DataEmpleadoDetalleTelefono]()
            datas.forEach({
                model.append(DataEmpleadoDetalleTelefono(attributes: $0))
            })
            self.telefono = model
        }
        self.duiFrente = attributes["dui_frente"] as? String
        self.duiReverso = attributes["dui_reverso"] as? String
        self.residencial = attributes["residencial"] as? String
        self.tipoResidente = attributes["tipo_residente"] as? String
        self.tieneResidencial = attributes["tiene_residencial"] as? Int
    }
}

// MARK: - Telefono
struct DataEmpleadoDetalleTelefono: Codable {
    var id: Int?
    var phone, telefonoDescription: String?
    var idUser, status: Int?
    var createdAt, updatedAt: String?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.phone = attributes["phone"] as? String
        self.telefonoDescription = attributes["description"] as? String
        self.idUser = attributes["id_user"] as? Int
        self.status = attributes["status"] as? Int
        self.createdAt = attributes["created_at"] as? String
        self.updatedAt = attributes["updated_at"] as? String
        
    }

}

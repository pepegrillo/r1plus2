//
//  Perfil.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

import UIKit

// MARK: - Perfil
struct Perfil: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataPerfil]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataPerfil]()
            datas.forEach({
                model.append(DataPerfil(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataPerfil
struct DataPerfil: Codable {
    var id: Int?
    var nombre, correo: String?
    var telefono: [DataPerfilTelefono]?
    var avatar: String?
    var residencial, ubicacion, sector, tipoResidente: String?
    var vivienda: String?
    var tieneResidencial: Int?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.nombre = attributes["Nombre"] as? String
        self.correo = attributes["correo"] as? String
        if let datas = attributes["telefono"] as? [[String:Any]] {
            var model = [DataPerfilTelefono]()
            datas.forEach({
                model.append(DataPerfilTelefono(attributes: $0))
            })
            self.telefono = model
        }
        self.avatar = attributes["avatar"] as? String
        self.residencial = attributes["residencial"] as? String
        self.ubicacion = attributes["ubicacion"] as? String
        self.sector = attributes["sector"] as? String
        self.tipoResidente = attributes["tipo_residente"] as? String
        self.vivienda = attributes["vivienda"] as? String
        self.tieneResidencial = attributes["tiene_residencial"] as? Int
    }
}

// MARK: - Telefono
struct DataPerfilTelefono: Codable {
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

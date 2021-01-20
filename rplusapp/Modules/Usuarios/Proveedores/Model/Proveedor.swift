//
//  Proveedor.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

import UIKit

// MARK: - Proveedor
struct Proveedor: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataProveedor]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataProveedor]()
            datas.forEach({
                model.append(DataProveedor(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataPerfil
struct DataProveedor: Codable {
    var id: Int?
    var name, lastName, avatar, logo: String?
    var telefonos: [DataProveedorTelefono]?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.name = attributes["name"] as? String
        self.lastName = attributes["last_name"] as? String
        self.avatar = attributes["avatar"] as? String
        self.logo = attributes["logo"] as? String
        if let datas = attributes["telefonos"] as? [[String:Any]] {
            var model = [DataProveedorTelefono]()
            datas.forEach({
                model.append(DataProveedorTelefono(attributes: $0))
            })
            self.telefonos = model
        }
        
    }
}

// MARK: - Telefono
struct DataProveedorTelefono: Codable {
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

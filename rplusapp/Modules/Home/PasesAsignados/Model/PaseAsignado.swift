//
//  PaseAsignado.swift
//  rplusapp
//
//  Created by Josué López on 12/4/20.
//

import UIKit

// MARK: - PaseAsignado
struct PaseAsignado: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataPaseAsignado]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataPaseAsignado]()
            datas.forEach({
                model.append(DataPaseAsignado(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataPaseAsignado
struct DataPaseAsignado: Codable {
    var id: Int?
    var code, name, lastName, email: String?
    var date, hour, phone: String?
    var entryTime, closeTime: String?
    var placeType, idLugar, idEmpresa, typeDocument: Int?
    var documentNumber, vehiclePlate, coment: String?
    var status, idUser, createdBy, idEstadoPase: Int?
    var createdAt, updatedAt: String?
    
    //agregados nuevos
    var lugar: LugarPaseAsignado?
    var tipo: TipoResidentePaseAsignado?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.code = attributes["code"] as? String
        self.name = attributes["name"] as? String
        self.lastName = attributes["last_name"] as? String
        self.email = attributes["email"] as? String
        self.date = attributes["date"] as? String
        self.hour = attributes["hour"] as? String
        self.phone = attributes["phone"] as? String
        self.entryTime = attributes["entry_time"] as? String
        self.closeTime = attributes["close_time"] as? String
        self.placeType = attributes["place_type"] as? Int
        self.idLugar = attributes["id_lugar"] as? Int
        self.idEmpresa = attributes["id_empresa"] as? Int
        self.typeDocument = attributes["type_document"] as? Int
        self.documentNumber = attributes["document_number"] as? String
        self.vehiclePlate = attributes["vehicle_plate"] as? String
        self.coment = attributes["coment"] as? String
        self.status = attributes["status"] as? Int
        self.idUser = attributes["id_user"] as? Int
        self.createdBy = attributes["created_by"] as? Int
        self.idEstadoPase = attributes["id_estado_pase"] as? Int
        self.createdAt = attributes["created_at"] as? String
        self.updatedAt = attributes["updated_at"] as? String
        
        if let contentLugar = attributes["lugar"] as? [String:Any] {
            self.lugar = LugarPaseAsignado(attributes: contentLugar)
        }
        if let contentTipo = attributes["tipo"] as? [String:Any] {
            self.tipo = TipoResidentePaseAsignado(attributes: contentTipo)
        }
        
    }
}

// MARK: - LugarPaseAsignado
struct LugarPaseAsignado: Codable {
    
    var name: String?
    var description: String?
    
    init(attributes: [String: Any]) {
        self.name = attributes["name"] as? String
        self.description = attributes["description"] as? String
    }
}

// MARK: - LugarPaseAsignado
struct TipoResidentePaseAsignado: Codable {
    
    var name: String?
    
    init(attributes: [String: Any]) {
        self.name = attributes["name"] as? String
    }
}

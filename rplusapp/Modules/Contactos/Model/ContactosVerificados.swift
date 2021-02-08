//
//  ContactosVerificados.swift
//  rplusapp
//
//  Created by Josue Lopez on 1/25/21.
//

import UIKit

// contactos extraidos desde Agenda iOS
struct FetchedContact {
    var firstName: String
    var lastName: String
    var telephone: String
    var avatar: Data?
}

// contactos verificados desde Agenda a Array
struct ContactosVerificados {
    var idUser: String
    var phone: String
    var existe: String
    var verificado: String // borrar este key, si ya esta clasificado
    var tipo: String // que tipo de visita es
    var avatar: Data?
    var name: String
    
}

// contactos verificados desde WS
struct ContactosVerificadosWs: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataContactosVerificadosWs]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataContactosVerificadosWs]()
            datas.forEach({
                model.append(DataContactosVerificadosWs(attributes: $0))
            })
            self.data = model
        }
    }
}

// DataContactosVerificadosWs
struct DataContactosVerificadosWs: Codable {
    var idUser: Int?
    var phoneLocal: String?
    var phone: String?
    var existe: Int?
    var verificado: Int?
    var tipo: String?
    var avatar: String?
    var name: String?
    
    init(attributes: [String: Any]) {
        self.idUser = attributes["id_user"] as? Int
        self.phoneLocal = attributes["anterior"] as? String
        self.phone = attributes["telefono"] as? String
        self.existe = attributes["existe"] as? Int
        self.verificado = attributes["verificado"] as? Int
        self.tipo = attributes["tipo"] as? String
        self.avatar = attributes["avatar"] as? String
        self.name = attributes["name"] as? String
        
    }
}

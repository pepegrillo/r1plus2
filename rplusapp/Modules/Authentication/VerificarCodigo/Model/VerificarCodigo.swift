//
//  VerificarCodigo.swift
//  rplusapp
//
//  Created by Josué López on 11/24/20.
//

import UIKit

// MARK: - VerificarCodigo
struct VerificarCodigo: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataVerificarCodigo]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataVerificarCodigo]()
            datas.forEach({
                model.append(DataVerificarCodigo(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataVerificarCodigo
struct DataVerificarCodigo: Codable {
    var id: Int?
    var name, lastName, email: String?
    var residenctial: Int?
    var token: String?

    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.name = attributes["name"] as? String
        self.lastName = attributes["last_name"] as? String
        self.email = attributes["email"] as? String
        self.residenctial = attributes["residenctial"] as? Int
        self.token = attributes["token"] as? String
    }
}

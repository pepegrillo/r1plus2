//
//  Alerta.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

import UIKit

// MARK: - Alerta
struct Alerta: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataAlerta]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataAlerta]()
            datas.forEach({
                model.append(DataAlerta(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataAlerta
struct DataAlerta: Codable {
    var id: Int?
    var name, imgAlerta: String?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.name = attributes["name"] as? String
        self.imgAlerta = attributes["img_alerta_movil"] as? String
        
    }
}


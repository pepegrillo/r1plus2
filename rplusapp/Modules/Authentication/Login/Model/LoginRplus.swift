//
//  LoginRplus.swift
//  rplusapp
//
//  Created by Josué López on 11/23/20.
//

import UIKit

// MARK: - LoginRplus
struct LoginRplus: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataLoginRplus]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataLoginRplus]()
            datas.forEach({
                model.append(DataLoginRplus(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataLoginRplus
struct DataLoginRplus: Codable {
    var id: Int?
    var name, lastName, email, token: String?

    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.name = attributes["name"] as? String
        self.lastName = attributes["last_name"] as? String
        self.email = attributes["email"] as? String
        self.token = attributes["token"] as? String
    }
}

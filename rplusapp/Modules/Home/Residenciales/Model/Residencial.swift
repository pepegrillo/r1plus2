//
//  Residencial.swift
//  rplusapp
//
//  Created by Josué López on 11/17/20.
//

import UIKit

// MARK: - Residencial
struct Residencial: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataResidencial]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataResidencial]()
            datas.forEach({
                model.append(DataResidencial(attributes: $0))
            })
            self.data = model
        }
    }
}

// Residencial Model
struct DataResidencial: Codable {
    
    var id: Int?
    var name: String?
    var logo: String?
    var description: String?
    var status: Int?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.name = attributes["name"] as? String
        self.logo = attributes["logo"] as? String
        self.description = attributes["description"] as? String
        self.status = attributes["status"] as? Int
    }
}

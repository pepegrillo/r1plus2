//
//  Restriccion.swift
//  rplusapp
//
//  Created by Josué López on 12/2/20.
//

import UIKit

// MARK: - Restriccion
struct Restriccion: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataRestriccion]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataRestriccion]()
            datas.forEach({
                model.append(DataRestriccion(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataRestriccion
struct DataRestriccion: Codable {
    var id: Int?
    var title, description: String?
    var pdf: String?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.title = attributes["title"] as? String
        self.description = attributes["description"] as? String
        self.pdf = attributes["pdf"] as? String
        
    }
}

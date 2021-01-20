//
//  Beneficio.swift
//  rplusapp
//
//  Created by Josué López on 12/2/20.
//

import UIKit

// MARK: - Beneficio
struct Beneficio: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataBeneficio]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataBeneficio]()
            datas.forEach({
                model.append(DataBeneficio(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataBeneficio
struct DataBeneficio: Codable {
    var id: Int?
    var title, description: String?
    var image: String?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.title = attributes["title"] as? String
        self.description = attributes["description"] as? String
        self.image = attributes["image"] as? String
        
    }
}

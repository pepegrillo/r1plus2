//
//  TipoAreaComun.swift
//  rplusapp
//
//  Created by Josué López on 11/26/20.
//

import UIKit

// MARK: - TipoAreaComun
struct TipoAreaComun: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataTipoAreaComun]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataTipoAreaComun]()
            datas.forEach({
                model.append(DataTipoAreaComun(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataTipoAreaComun
struct DataTipoAreaComun: Codable {
    var id: Int?
    var name, description: String?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.name = attributes["name"] as? String
        self.description = attributes["description"] as? String
    }
}

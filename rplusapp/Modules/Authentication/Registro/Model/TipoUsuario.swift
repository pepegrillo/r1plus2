//
//  TipoUsuario.swift
//  rplusapp
//
//  Created by Josué López on 11/24/20.
//

import UIKit

// MARK: - TipoUsuario
struct TipoUsuario: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataTipoUsuario]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataTipoUsuario]()
            datas.forEach({
                model.append(DataTipoUsuario(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataTipoUsuario
struct DataTipoUsuario: Codable {
    var id: Int?
    var title: String?

    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.title = attributes["title"] as? String
    }
}

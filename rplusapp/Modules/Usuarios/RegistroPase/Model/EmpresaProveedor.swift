//
//  EmpresaProveedor.swift
//  rplusapp
//
//  Created by Josué López on 11/26/20.
//

import UIKit

// MARK: - EmpresaProveedor
struct EmpresaProveedor: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataEmpresaProveedor]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataEmpresaProveedor]()
            datas.forEach({
                model.append(DataEmpresaProveedor(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataEmpresaProveedor
struct DataEmpresaProveedor: Codable {
    var id: Int?
    var name: String?
    var logo: String?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.name = attributes["name"] as? String
        self.logo = attributes["logo"] as? String
    }
}

//
//  TipoMascota.swift
//  rplusapp
//
//  Created by Josué López on 12/1/20.
//

import UIKit

// MARK: - TipoMascota
struct TipoMascota: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataTipoMascota]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
//        if let datas = attributes["data"] as? [[[String:Any]]] {
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataTipoMascota]()

            datas.forEach({
//                $0.forEach({
                    model.append(DataTipoMascota(attributes: $0))
//                })
            })
            
            self.data = model
        }
    }
}

// MARK: - DataTipoMascota
struct DataTipoMascota: Codable {
    var id: Int?
    var name: String?

    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.name = attributes["name"] as? String
    }
}

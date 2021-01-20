//
//  Anuncio.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

// MARK: - Anuncio
struct Anuncio: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataAnuncio]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataAnuncio]()
            datas.forEach({
                model.append(DataAnuncio(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataAnuncio
struct DataAnuncio: Codable {
    var id: Int?
    var title, description: String?
    var order: Int?
    var expirationDate, image: String?
    var status, createdBy, idResidencial: Int?
    var createdAt, updatedAt: String?

    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.title = attributes["title"] as? String
        self.description = attributes["description"] as? String
        self.order = attributes["order"] as? Int
        self.expirationDate = attributes["expiration_date"] as? String
        self.image = attributes["image"] as? String
        self.status = attributes["status"] as? Int
        self.createdBy = attributes["created_by"] as? Int
        self.idResidencial = attributes["id_residencial"] as? Int
        self.createdAt = attributes["created_at"] as? String
        self.updatedAt = attributes["updated_at"] as? String
    }
}

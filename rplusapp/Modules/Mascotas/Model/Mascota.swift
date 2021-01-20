//
//  Mascota.swift
//  rplusapp
//
//  Created by Josué López on 11/19/20.
//

// MARK: - Mascota
struct Mascota: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataMascota]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataMascota]()
            datas.forEach({
                model.append(DataMascota(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataMascota
struct DataMascota: Codable {
    var id: Int?
    var name, breed, photoPet, photoCard: String?
    var description: String?
    var status, idUser, idResidencial, idTipoMascota: Int?
    var createdAt, updatedAt: String?

    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.name = attributes["name"] as? String
        self.breed = attributes["breed"] as? String
        self.photoPet = attributes["photo_pet"] as? String
        self.photoCard = attributes["photo_card"] as? String
        self.description = attributes["description"] as? String
        self.status = attributes["status"] as? Int
        self.idUser = attributes["id_user"] as? Int
        self.idResidencial = attributes["id_residencial"] as? Int
        self.idTipoMascota = attributes["id_tipo_mascota"] as? Int
        self.createdAt = attributes["created_at"] as? String
        self.updatedAt = attributes["updated_at"] as? String
    }
}

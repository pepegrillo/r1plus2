//
//  PerfilMascota.swift
//  rplusapp
//
//  Created by Josué López on 12/1/20.
//

// MARK: - PerfilMascota
struct PerfilMascota: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataPerfilMascota]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataPerfilMascota]()
            datas.forEach({
                model.append(DataPerfilMascota(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataPerfilMascota
struct DataPerfilMascota: Codable {
    var residencial, vivienda, responsable, name: String?
    var description, breed, photoPet, phone: String?
    var tipoMascota: String?

    init(attributes: [String: Any]) {
        self.residencial = attributes["residencial"] as? String
        self.vivienda = attributes["vivienda"] as? String
        self.responsable = attributes["responsable"] as? String
        self.name = attributes["name"] as? String
        self.description = attributes["description"] as? String
        self.breed = attributes["breed"] as? String
        self.photoPet = attributes["photo_pet"] as? String
        self.phone = attributes["phone"] as? String
        self.tipoMascota = attributes["tipo_mascota"] as? String
    }
}

//
//  ReporteDetalle.swift
//  rplusapp
//
//  Created by Josue Lopez Desarrollo on 3/3/21.
//

import UIKit

// MARK: - Perfil
struct ReporteDetalle: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    var data: [DataReporteDetalle]?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        if let datas = attributes["data"] as? [[String:Any]] {
            var model = [DataReporteDetalle]()
            datas.forEach({
                model.append(DataReporteDetalle(attributes: $0))
            })
            self.data = model
        }
    }
}

// MARK: - DataReporte
struct DataReporteDetalle: Codable {
    var id: Int?
    var description: String?
    var latitud, longitud: Double?
    
    var alerta: ReporteAlerta?
    var historial: [ReporteHistorial]?
    
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.description = attributes["description"] as? String
        self.latitud = attributes["latitud"] as? Double
        self.longitud = attributes["longitud"] as? Double
        
        if let contentAlerta = attributes["alerta"] as? [String:Any] {
            self.alerta = ReporteAlerta(attributes: contentAlerta)
        }
        
        if let contentHistorial = attributes["historial"] as? [[String:Any]] {
            var model = [ReporteHistorial]()
            contentHistorial.forEach({
                model.append(ReporteHistorial(attributes: $0))
            })
            self.historial = model
        }
        
    }
}

// MARK: - ReporteAlerta
struct ReporteAlerta: Codable {
    
    var name: String?
    var imgAlertaMovil: String?
    
    init(attributes: [String: Any]) {
        self.name = attributes["name"] as? String
        self.imgAlertaMovil = attributes["img_alerta_movil"] as? String
    }
}

// MARK: - ReporteHistorial
struct ReporteHistorial: Codable {
    
    var id: Int?
    var msg: String?
    var estado: ReporteHistorialEstado?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.msg = attributes["msg"] as? String
        
        if let contentEstado = attributes["estado"] as? [String:Any] {
            self.estado = ReporteHistorialEstado(attributes: contentEstado)
        }
    }
}

// MARK: - ReporteHistorialEstado
struct ReporteHistorialEstado: Codable {
    
    var id: Int?
    var name, created_at: String?
    
    init(attributes: [String: Any]) {
        self.id = attributes["id"] as? Int
        self.name = attributes["name"] as? String
        self.created_at = attributes["created_at"] as? String
    }
}

//
//  OpcionViewModel.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

import Foundation

class OpcionViewModel: NSObject {
    
    func allLayers() -> [Opcion] {
        
        var layers: [Opcion] = []
        
        layers.append(.miPerfil)
        layers.append(.agregarResidencial)
        layers.append(.agregarCasa)
        layers.append(.directorio)
        layers.append(.historialPases)
        layers.append(.historialPagos)
        layers.append(.usuariosAdicionales)
        layers.append(.mascotas)
        layers.append(.beneficiosResidencia)
        layers.append(.restriccionesResidencia)
        layers.append(.cerrarSesion)
        
        return layers
        
    }
}

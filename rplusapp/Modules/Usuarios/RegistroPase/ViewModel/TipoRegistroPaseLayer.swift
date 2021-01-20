//
//  TipoRegistroPaseLayer.swift
//  rplusapp
//
//  Created by Josué López on 11/26/20.
//

import Foundation

enum TipoRegistroPaseLayer {
    case empleado
    case proveedor
    case visitaFrecuente
    case visitaEventual
    
    var name: String {
        switch self {
            case .empleado:
                return "Empleado"
            case .proveedor:
                return "Proveedor"
            case .visitaFrecuente:
                return "Visita Frecuente"
            case .visitaEventual:
                return "Visita Eventual"
        }
    }
    
    var value: String {
        switch self {
            case .empleado:
                return "1"
            case .proveedor:
                return "2"
            case .visitaFrecuente:
                return "7"
            case .visitaEventual:
                return "8"
        }
    }
}

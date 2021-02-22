//
//  Opcion.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

import UIKit

enum Opcion {
    case miPerfil
    case agregarResidencial
    case agregarCasa
    case directorio
    case historialPases
    case historialPagos
    case usuariosAdicionales
    case mascotas
    case beneficiosResidencia
    case restriccionesResidencia
    case cerrarSesion
    
    var name: String {
        switch self {
            case .miPerfil: return "Mi perfil"
            case .agregarResidencial: return "Agregar residencial"
            case .agregarCasa: return "Agregar casa"
            case .directorio: return "Directorio"
            case .historialPases: return "Historial de pases o visitas"
            case .historialPagos: return "Historial de pagos"
            case .usuariosAdicionales: return "Usuarios adicionales"
            case .mascotas: return "Mascotas"
            case .beneficiosResidencia: return "Beneficios de la residencia"
            case .restriccionesResidencia: return "Reglamentos"
            case .cerrarSesion: return "Cerrar sesion"
        }
    }
    
    var iconName: String {
        switch self {
            case .miPerfil: return "IconOpcionPerfin"
            case .agregarResidencial: return "IconOpcionAgregarResidencia"
            case .agregarCasa: return "IconOpcionAgregarCasa"
            case .directorio: return "IconOpcionDirectorio"
            case .historialPases: return "IconOpcionHistorialPases"
            case .historialPagos: return "IconOpcionHistorialPagos"
            case .usuariosAdicionales: return "IconOpcionUsuarios"
            case .mascotas: return "IconOpcionMascotas"
            case .beneficiosResidencia: return "IconOpcionBeneficios"
            case .restriccionesResidencia: return "IconOpcionBeneficios"
            case .cerrarSesion: return "IconOpcionLogout"
        }
    }
    
    var identifier: String {
        return "OpcionCell"
    }
}

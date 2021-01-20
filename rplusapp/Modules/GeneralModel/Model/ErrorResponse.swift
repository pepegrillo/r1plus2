//
//  ErrorResponse.swift
//  rplusapp
//
//  Created by Josué López on 11/17/20.
//

import UIKit

struct ErrorResponse {

    enum errorResponseCode: Int {
        case errorTransaccion = 1
        case inicioSesionExitoso = 2
        case usuarioNoAutorizado = 3
        case errorValidarDatos = 4
        case registroExitoso = 5
        case actualizacionExitosa = 6
        case recuperacionListaRegistroExitosa = 7
        case eliminacionExitosa = 8
        case recuperacionRegistroExitoso = 9
        case registroNoEncontrado = 10
        case errorEliminacionRegistro = 11
        case exitoCerrarSesion = 12
        case usuarioNoExiste = 13
    }

    enum errorResponseMessage: String {
        case errorTransaccion = "Error de Transacción"
        case inicioSesionExitoso = "Inicio de sesión exitoso"
        case usuarioNoAutorizado = "Usuario no Autorizado"
        case errorValidarDatos = "Error de validación de datos"
        case registroExitoso = "Registro exitoso"
        case actualizacionExitosa = "Actualización Exitosa"
        case recuperacionListaRegistroExitosa = "Recuperación de lista de registros exitosa"
        case eliminacionExitosa = "Eliminación Exitosa"
        case recuperacionRegistroExitoso = "Recuperación de registro exitoso"
        case registroNoEncontrado = "Registro no encontrado"
        case errorEliminacionRegistro = "Error de eliminación de registro"
        case exitoCerrarSesion = "Éxito al cerrar sesión"
        case usuarioNoExiste = "El usuario no existe, proceda a registrarse"
    }
    
}

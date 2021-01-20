//
//  UbicacionViewModel.swift
//  rplusapp
//
//  Created by Josué López on 11/25/20.
//

import UIKit

protocol UbicacionDelegate: class {
    func ubicacionCompleted()
    func ubicacionCompleted(with error: String)
}

struct UbicacionViewModel {
    
    weak var delegate: UbicacionDelegate?
    
    init(delegate: UbicacionDelegate) {
        self.delegate = delegate
    }
    
    func requestUbicacion(paramIdSector: Int) {
        
        AgregarCasaWS().getUbicacionPorSector(idSector: "\(paramIdSector)", completion: { (dataResponse, error) in
            
            print("------> \(dataResponse ?? .init())")
            
            guard error == nil else {
                self.delegate?.ubicacionCompleted(with: error?.localizedDescription ?? "error desconocido")
                return
            }
            guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.actualizacionExitosa.rawValue else {
                
                // check for WS errors
                switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                    case .errorTransaccion:
                         self.delegate?.ubicacionCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                    case .inicioSesionExitoso:
                         self.delegate?.ubicacionCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                    case .usuarioNoAutorizado:
                         self.delegate?.ubicacionCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                    case .errorValidarDatos:
                         self.delegate?.ubicacionCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                    case .registroExitoso:
                         self.delegate?.ubicacionCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                    case .actualizacionExitosa:
                         self.delegate?.ubicacionCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                    case .recuperacionListaRegistroExitosa:
                         self.delegate?.ubicacionCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                    case .eliminacionExitosa:
                         self.delegate?.ubicacionCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                    case .recuperacionRegistroExitoso:
                         self.delegate?.ubicacionCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                    case .registroNoEncontrado:
                         self.delegate?.ubicacionCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                    case .errorEliminacionRegistro:
                         self.delegate?.ubicacionCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                    case .exitoCerrarSesion:
                         self.delegate?.ubicacionCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                    case .usuarioNoExiste:
                         self.delegate?.ubicacionCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                    default:
                         self.delegate?.ubicacionCompleted(with: "Error no encontrado")
                }
                
                print("ERRORORE")
                return
            }
            
            // MARK: setting model
            GlobalParameters.instance().globalDataUbicacionPorSector = dataResponse?.data ?? .init()
            self.delegate?.ubicacionCompleted()
                
        })
    }
    
}

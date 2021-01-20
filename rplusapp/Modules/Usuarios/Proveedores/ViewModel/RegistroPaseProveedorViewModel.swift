//
//  RegistroPaseProveedorViewModel.swift
//  rplusapp
//
//  Created by Josué López on 11/26/20.
//

import UIKit

protocol RegistroPaseProveedorDelegate: class {
    func RegistroPaseProveedorRequestCompleted()
    func RegistroPaseProveedorRequestCompleted(with error: String)
}

struct RegistroPaseProveedorViewModel {
    
    weak var delegate: RegistroPaseProveedorDelegate?
    
    init(delegate: RegistroPaseProveedorDelegate) {
        self.delegate = delegate
    }
    
    func requestRegistroPaseProveedor(body: [String]) {
        
            
            RegistroProveedorWS().postRegistroProveedor(body: body, completion: { (dataResponse, error) in
                
                print("\(dataResponse ?? .init())")
                guard error == nil else {
                    self.delegate?.RegistroPaseProveedorRequestCompleted(with: error?.localizedDescription ?? "error desconocido")
                    return
                }
                
                print("errorCode \(String(describing: dataResponse?.errorCode)) \(String(describing: dataResponse?.message))")
                
                guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.errorValidarDatos.rawValue else {
                    
                    // check for WS errors
                    switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                        case .errorTransaccion:
                             self.delegate?.RegistroPaseProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                        case .inicioSesionExitoso:
                             self.delegate?.RegistroPaseProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                        case .usuarioNoAutorizado:
                             self.delegate?.RegistroPaseProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                        case .errorValidarDatos:
                             self.delegate?.RegistroPaseProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                        case .registroExitoso:
                             self.delegate?.RegistroPaseProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                        case .actualizacionExitosa:
                             self.delegate?.RegistroPaseProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                        case .recuperacionListaRegistroExitosa:
                             self.delegate?.RegistroPaseProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                        case .eliminacionExitosa:
                             self.delegate?.RegistroPaseProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                        case .recuperacionRegistroExitoso:
                             self.delegate?.RegistroPaseProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                        case .registroNoEncontrado:
                             self.delegate?.RegistroPaseProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                        case .errorEliminacionRegistro:
                             self.delegate?.RegistroPaseProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                        case .exitoCerrarSesion:
                             self.delegate?.RegistroPaseProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                        case .usuarioNoExiste:
                             self.delegate?.RegistroPaseProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                        default:
                             self.delegate?.RegistroPaseProveedorRequestCompleted(with: "Error no encontrado")
                    }
                    
                    print("ERRORORE")
                    return
                }
                
                
                // MARK: setting model
                self.delegate?.RegistroPaseProveedorRequestCompleted()
                
                
            })
        
    }
    
}

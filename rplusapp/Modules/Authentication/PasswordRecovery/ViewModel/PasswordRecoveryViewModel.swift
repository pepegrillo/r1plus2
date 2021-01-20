//
//  PasswordRecoveryViewModel.swift
//  rplusapp
//
//  Created by Josué López on 12/18/20.
//

import UIKit

protocol PasswordRecoveryDelegate: class {
    func passwordRecoveryCompleted()
    func passwordRecoveryCompleted(with error: String)
}

struct PasswordRecoveryViewModel {
    
    weak var delegate: PasswordRecoveryDelegate?
    
    init(delegate: PasswordRecoveryDelegate) {
        self.delegate = delegate
    }
    
    func requestPasswordRecovery(body: [String]) {
        
        PasswordRecoveryWS().postPasswordRecovery(body: body, completion: { (dataResponse, error) in
            
            print("------> \(String(describing: dataResponse))")
            
            guard error == nil else {
                self.delegate?.passwordRecoveryCompleted(with: error?.localizedDescription ?? "error desconocido")
                return
            }
            guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.errorValidarDatos.rawValue else {
                
                // check for WS errors
                switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                    case .errorTransaccion:
                         self.delegate?.passwordRecoveryCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                    case .inicioSesionExitoso:
                         self.delegate?.passwordRecoveryCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                    case .usuarioNoAutorizado:
                         self.delegate?.passwordRecoveryCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                    case .errorValidarDatos:
                         self.delegate?.passwordRecoveryCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                    case .registroExitoso:
                         self.delegate?.passwordRecoveryCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                    case .actualizacionExitosa:
                         self.delegate?.passwordRecoveryCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                    case .recuperacionListaRegistroExitosa:
                         self.delegate?.passwordRecoveryCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                    case .eliminacionExitosa:
                         self.delegate?.passwordRecoveryCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                    case .recuperacionRegistroExitoso:
                         self.delegate?.passwordRecoveryCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                    case .registroNoEncontrado:
                         self.delegate?.passwordRecoveryCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                    case .errorEliminacionRegistro:
                         self.delegate?.passwordRecoveryCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                    case .exitoCerrarSesion:
                         self.delegate?.passwordRecoveryCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                    case .usuarioNoExiste:
                         self.delegate?.passwordRecoveryCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                    default:
                         self.delegate?.passwordRecoveryCompleted(with: "Error no encontrado")
                }
                
                print("ERRORORE")
                return
            }
            
            // MARK: setting model
            guard let data = dataResponse else {
                self.delegate?.passwordRecoveryCompleted(with: "Token no encontrado")
                return
            }
            
            self.delegate?.passwordRecoveryCompleted()
                
        })
    }
    
}

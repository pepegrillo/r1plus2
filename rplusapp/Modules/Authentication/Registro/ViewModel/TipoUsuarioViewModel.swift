//
//  TipoUsuarioViewModel.swift
//  rplusapp
//
//  Created by Josué López on 11/24/20.
//

import UIKit

protocol TipoUsuarioDelegate: class {
    func tipoUsuarioCompleted()
    func tipoUsuarioCompleted(with error: String)
}

struct TipoUsuarioViewModel {
    
    weak var delegate: TipoUsuarioDelegate?
    
    init(delegate: TipoUsuarioDelegate) {
        self.delegate = delegate
    }
    
    func requestTipoUsuario() {
        
        TipoUsuarioWS().getTipoUsuarioList(completion: { (dataResponse, error) in
            
            guard error == nil else {
                self.delegate?.tipoUsuarioCompleted(with: error?.localizedDescription ?? "error desconocido")
                return
            }
            guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.actualizacionExitosa.rawValue else {
                
                // check for WS errors
                switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                    case .errorTransaccion:
                         self.delegate?.tipoUsuarioCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                    case .inicioSesionExitoso:
                         self.delegate?.tipoUsuarioCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                    case .usuarioNoAutorizado:
                         self.delegate?.tipoUsuarioCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                    case .errorValidarDatos:
                         self.delegate?.tipoUsuarioCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                    case .registroExitoso:
                         self.delegate?.tipoUsuarioCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                    case .actualizacionExitosa:
                         self.delegate?.tipoUsuarioCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                    case .recuperacionListaRegistroExitosa:
                         self.delegate?.tipoUsuarioCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                    case .eliminacionExitosa:
                         self.delegate?.tipoUsuarioCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                    case .recuperacionRegistroExitoso:
                         self.delegate?.tipoUsuarioCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                    case .registroNoEncontrado:
                         self.delegate?.tipoUsuarioCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                    case .errorEliminacionRegistro:
                         self.delegate?.tipoUsuarioCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                    case .exitoCerrarSesion:
                         self.delegate?.tipoUsuarioCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                    case .usuarioNoExiste:
                         self.delegate?.tipoUsuarioCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                    default:
                         self.delegate?.tipoUsuarioCompleted(with: "Error no encontrado")
                }
                
                print("ERRORORE")
                return
            }
            
            GlobalParameters.instance().globalDataTipoUsuario = dataResponse?.data ?? .init()
            self.delegate?.tipoUsuarioCompleted()
                
            
        })
    }
}

//
//  PerfilViewModel.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

import UIKit

protocol PerfilViewModelDelegate: class {
    func perfilViewModelRequestCompleted()
    func perfilViewModelRequestCompleted(with error: String)
}

class PerfilViewModel {
    
    weak var delegate: PerfilViewModelDelegate?
    
    init(delegate: PerfilViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Get WS
    func requestGetPerfil() {
        
        print("inicio")
        PerfilWS().getPerfil(completion: { (dataResponse, error) in
            
            guard error == nil else {
                self.delegate?.perfilViewModelRequestCompleted(with: error?.localizedDescription ?? "error desconocido")
                return
            }
            
            guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.eliminacionExitosa.rawValue else {
                
                // check for WS errors
                switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                    case .errorTransaccion:
                         self.delegate?.perfilViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                    case .inicioSesionExitoso:
                         self.delegate?.perfilViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                    case .usuarioNoAutorizado:
                         self.delegate?.perfilViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                    case .errorValidarDatos:
                         self.delegate?.perfilViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                    case .registroExitoso:
                         self.delegate?.perfilViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                    case .actualizacionExitosa:
                         self.delegate?.perfilViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                    case .recuperacionListaRegistroExitosa:
                         self.delegate?.perfilViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                    case .eliminacionExitosa:
                         self.delegate?.perfilViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                    case .recuperacionRegistroExitoso:
                         self.delegate?.perfilViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                    case .registroNoEncontrado:
                         self.delegate?.perfilViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                    case .errorEliminacionRegistro:
                         self.delegate?.perfilViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                    case .exitoCerrarSesion:
                         self.delegate?.perfilViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                    case .usuarioNoExiste:
                         self.delegate?.perfilViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                    default:
                         self.delegate?.perfilViewModelRequestCompleted(with: "Error no encontrado")
                }
                
                print("ERRORORE")
                return
            }
            
            
            print("respuesta WS ----> \(dataResponse)")
            
            // MARK: setting model
            GlobalParameters.instance().globalDataPerfil = dataResponse?.data ?? .init()
            AppData.sharedData.saveIdResidencial(paramIdResidencial: "\(dataResponse?.data?[0].tieneResidencial ?? 0)")
            self.delegate?.perfilViewModelRequestCompleted()
            
            
        })
    }
}

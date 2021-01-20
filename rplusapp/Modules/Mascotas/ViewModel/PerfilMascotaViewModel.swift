//
//  PerfilMascotaViewModel.swift
//  rplusapp
//
//  Created by Josué López on 12/1/20.
//

import UIKit

protocol PerfilMascotaViewModelDelegate: class {
    func perfilMascotaViewModelRequestCompleted()
    func perfilMascotaViewModelRequestCompleted(with error: String)
}

class PerfilMascotaViewModel {
    
    weak var delegate: PerfilMascotaViewModelDelegate?
    
    init(delegate: PerfilMascotaViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Get WS
    func requestGetPerfilMascota(paramIdMascota: Int) {
        
        print("inicio")
        PerfilMascotaWS().getPerfilMascota(idMascota: paramIdMascota, completion: { (dataResponse, error) in
            
            guard error == nil else {
                self.delegate?.perfilMascotaViewModelRequestCompleted(with: error?.localizedDescription ?? "error desconocido")
                return
            }
            
            guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.eliminacionExitosa.rawValue else {
                
                // check for WS errors
                switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                    case .errorTransaccion:
                         self.delegate?.perfilMascotaViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                    case .inicioSesionExitoso:
                         self.delegate?.perfilMascotaViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                    case .usuarioNoAutorizado:
                         self.delegate?.perfilMascotaViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                    case .errorValidarDatos:
                         self.delegate?.perfilMascotaViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                    case .registroExitoso:
                         self.delegate?.perfilMascotaViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                    case .actualizacionExitosa:
                         self.delegate?.perfilMascotaViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                    case .recuperacionListaRegistroExitosa:
                         self.delegate?.perfilMascotaViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                    case .eliminacionExitosa:
                         self.delegate?.perfilMascotaViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                    case .recuperacionRegistroExitoso:
                         self.delegate?.perfilMascotaViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                    case .registroNoEncontrado:
                         self.delegate?.perfilMascotaViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                    case .errorEliminacionRegistro:
                         self.delegate?.perfilMascotaViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                    case .exitoCerrarSesion:
                         self.delegate?.perfilMascotaViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                    case .usuarioNoExiste:
                         self.delegate?.perfilMascotaViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                    default:
                         self.delegate?.perfilMascotaViewModelRequestCompleted(with: "Error no encontrado")
                }
                
                print("ERRORORE")
                return
            }
            
            
            print("respuesta WS ----> \(dataResponse)")
            
            // MARK: setting model
            GlobalParameters.instance().globalDataPerfilMascota = dataResponse?.data ?? .init()
            self.delegate?.perfilMascotaViewModelRequestCompleted()
            
        })
    }
}

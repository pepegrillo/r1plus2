//
//  SetTipoResidenteViewModel.swift
//  rplusapp
//
//  Created by Josué López on 11/25/20.
//

import UIKit

protocol SetTipoResidenteDelegate: class {
    func setTipoResidenteCompleted()
    func setTipoResidenteCompleted(with error: String)
}

struct SetTipoResidenteViewModel {
    
    weak var delegate: SetTipoResidenteDelegate?
    
    init(delegate: SetTipoResidenteDelegate) {
        self.delegate = delegate
    }
    
    func requestSetTipoResidente(body: [String]) {
        
        SetTipoResidenteWS().postSetTipoResidente(body: body, completion: { (dataResponse, error) in
            
            print("------> \(dataResponse)")
            
            guard error == nil else {
                self.delegate?.setTipoResidenteCompleted(with: error?.localizedDescription ?? "error desconocido")
                return
            }
            guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.errorValidarDatos.rawValue else {
                
                // check for WS errors
                switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                    case .errorTransaccion:
                         self.delegate?.setTipoResidenteCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                    case .inicioSesionExitoso:
                         self.delegate?.setTipoResidenteCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                    case .usuarioNoAutorizado:
                         self.delegate?.setTipoResidenteCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                    case .errorValidarDatos:
                         self.delegate?.setTipoResidenteCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                    case .registroExitoso:
                         self.delegate?.setTipoResidenteCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                    case .actualizacionExitosa:
                         self.delegate?.setTipoResidenteCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                    case .recuperacionListaRegistroExitosa:
                         self.delegate?.setTipoResidenteCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                    case .eliminacionExitosa:
                         self.delegate?.setTipoResidenteCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                    case .recuperacionRegistroExitoso:
                         self.delegate?.setTipoResidenteCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                    case .registroNoEncontrado:
                         self.delegate?.setTipoResidenteCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                    case .errorEliminacionRegistro:
                         self.delegate?.setTipoResidenteCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                    case .exitoCerrarSesion:
                         self.delegate?.setTipoResidenteCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                    case .usuarioNoExiste:
                         self.delegate?.setTipoResidenteCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                    default:
                         self.delegate?.setTipoResidenteCompleted(with: "Error no encontrado")
                }
                
                print("ERRORORE")
                return
            }
            
            // MARK: setting model
            AppData.sharedData.saveIdResidencial(paramIdResidencial: "\(body[0])")
            self.delegate?.setTipoResidenteCompleted()
                
        })
    }
    
}

//
//  DeleteViewModel.swift
//  rplusapp
//
//  Created by Rene Borja on 1/16/21.
//

import UIKit

protocol DeleteDelegate: class {
    func DeleteRequestCompleted()
    func DeleteRequestCompleted(with error: String)
}

struct DeleteViewModel {
    
    weak var delegate: DeleteDelegate?
    
    init(delegate: DeleteDelegate) {
        self.delegate = delegate
    }
    
    func requestDelete(idIdElement: Int, idUrl: String) {
        
        
        DeleteWS().deleteElement(paramId: idIdElement, paramUrl: idUrl, completion: { (dataResponse, error) in
            
            print("\(dataResponse ?? .init())")
            guard error == nil else {
                self.delegate?.DeleteRequestCompleted(with: error?.localizedDescription ?? "error desconocido")
                return
            }
            
            print("errorCode \(String(describing: dataResponse?.errorCode)) \(String(describing: dataResponse?.message))")
            
            guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.recuperacionListaRegistroExitosa.rawValue else {
                
                // check for WS errors
                switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                case .errorTransaccion:
                    self.delegate?.DeleteRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                case .inicioSesionExitoso:
                    self.delegate?.DeleteRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                case .usuarioNoAutorizado:
                    self.delegate?.DeleteRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                case .errorValidarDatos:
                    self.delegate?.DeleteRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                case .registroExitoso:
                    self.delegate?.DeleteRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                case .actualizacionExitosa:
                    self.delegate?.DeleteRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                case .recuperacionListaRegistroExitosa:
                    self.delegate?.DeleteRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                case .eliminacionExitosa:
                    self.delegate?.DeleteRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                case .recuperacionRegistroExitoso:
                    self.delegate?.DeleteRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                case .registroNoEncontrado:
                    self.delegate?.DeleteRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                case .errorEliminacionRegistro:
                    self.delegate?.DeleteRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                case .exitoCerrarSesion:
                    self.delegate?.DeleteRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                case .usuarioNoExiste:
                    self.delegate?.DeleteRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                default:
                    self.delegate?.DeleteRequestCompleted(with: "Error no encontrado")
                }
                
                print("ERRORORE")
                return
            }
            
            
            // MARK: setting model
            self.delegate?.DeleteRequestCompleted()
            
            
        })
        
    }
    
}

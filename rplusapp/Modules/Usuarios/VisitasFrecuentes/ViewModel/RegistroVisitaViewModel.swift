//
//  RegistroVisitaViewModel.swift
//  rplusapp
//
//  Created by Josué López on 11/27/20.
//

import UIKit

protocol RegistroVisitaDelegate: class {
    func registroVisitaRequestCompleted()
    func registroVisitaRequestCompleted(with error: String)
}

struct RegistroVisitaViewModel {
    
    weak var delegate: RegistroVisitaDelegate?
    
    init(delegate: RegistroVisitaDelegate) {
        self.delegate = delegate
    }
    
    func requestRegistroVisita(body: [String]) {
        
            
        RegistroVisitaWS().postRegistroVisita(body: body, completion: { (dataResponse, error) in
                
                print("\(dataResponse ?? .init())")
                guard error == nil else {
                    self.delegate?.registroVisitaRequestCompleted(with: error?.localizedDescription ?? "error desconocido")
                    return
                }
                
                print("errorCode \(dataResponse?.errorCode) \(dataResponse?.message)")
                
                guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.errorValidarDatos.rawValue else {
                    
                    // check for WS errors
                    switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                        case .errorTransaccion:
                             self.delegate?.registroVisitaRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                        case .inicioSesionExitoso:
                             self.delegate?.registroVisitaRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                        case .usuarioNoAutorizado:
                             self.delegate?.registroVisitaRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                        case .errorValidarDatos:
                             self.delegate?.registroVisitaRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                        case .registroExitoso:
                             self.delegate?.registroVisitaRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                        case .actualizacionExitosa:
                             self.delegate?.registroVisitaRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                        case .recuperacionListaRegistroExitosa:
                             self.delegate?.registroVisitaRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                        case .eliminacionExitosa:
                             self.delegate?.registroVisitaRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                        case .recuperacionRegistroExitoso:
                             self.delegate?.registroVisitaRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                        case .registroNoEncontrado:
                             self.delegate?.registroVisitaRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                        case .errorEliminacionRegistro:
                             self.delegate?.registroVisitaRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                        case .exitoCerrarSesion:
                             self.delegate?.registroVisitaRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                        case .usuarioNoExiste:
                             self.delegate?.registroVisitaRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                        default:
                             self.delegate?.registroVisitaRequestCompleted(with: "Error no encontrado")
                    }
                    
                    print("ERRORORE")
                    return
                }
                
                
                // MARK: setting model
                self.delegate?.registroVisitaRequestCompleted()
                
                
            })
        
    }
    
}

//
//  RegistroViewModel.swift
//  rplusapp
//
//  Created by Josué López on 11/24/20.
//

import UIKit

protocol RegistroDelegate: class {
    func registroRequestCompleted()
    func registroRequestCompleted(with error: String)
}

struct RegistroViewModel {
    
    var isLoggedBefore: Bool {
        AppData.sharedData.getUserData() != nil
    }
    
    weak var delegate: RegistroDelegate?
    
    init(delegate: RegistroDelegate) {
        self.delegate = delegate
    }
    
    func requestRegistro(body: [String]) {
        
            
            RegistroWS().postRegistro(body: body, completion: { (dataResponse, error) in
                
                print("\(String(describing: dataResponse))")
                guard error == nil else {
                    self.delegate?.registroRequestCompleted(with: error?.localizedDescription ?? "error desconocido")
                    return
                }
                
                guard dataResponse?.success == true else {
                    self.delegate?.registroRequestCompleted(with: dataResponse?.message ?? "Error al procesar la solicitud.")
                    return
                }
                
                print("errorCode \(String(describing: dataResponse?.errorCode)) \(String(describing: dataResponse?.message))")
                
                guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.errorValidarDatos.rawValue else {
                    
                    // check for WS errors
                    switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                        case .errorTransaccion:
                             self.delegate?.registroRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                        case .inicioSesionExitoso:
                             self.delegate?.registroRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                        case .usuarioNoAutorizado:
                             self.delegate?.registroRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                        case .errorValidarDatos:
                             self.delegate?.registroRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                        case .registroExitoso:
                             self.delegate?.registroRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                        case .actualizacionExitosa:
                             self.delegate?.registroRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                        case .recuperacionListaRegistroExitosa:
                             self.delegate?.registroRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                        case .eliminacionExitosa:
                             self.delegate?.registroRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                        case .recuperacionRegistroExitoso:
                             self.delegate?.registroRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                        case .registroNoEncontrado:
                             self.delegate?.registroRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                        case .errorEliminacionRegistro:
                             self.delegate?.registroRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                        case .exitoCerrarSesion:
                             self.delegate?.registroRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                        case .usuarioNoExiste:
                             self.delegate?.registroRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                        default:
                             self.delegate?.registroRequestCompleted(with: "Error no encontrado")
                    }
                    
                    print("ERRORORE")
                    return
                }
                
                
                // MARK: setting model
                self.delegate?.registroRequestCompleted()
                
                
            })
        
    }
    
}

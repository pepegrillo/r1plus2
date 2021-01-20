//
//  LoginRplusViewModel.swift
//  rplusapp
//
//  Created by Josué López on 11/23/20.
//

import UIKit

protocol LoginRplusDelegate: class {
    func loginRplusRequestCompleted()
    func loginRplusRequestCompleted(with error: String)
}

struct LoginRplusViewModel {
    
    var isLoggedBefore: Bool {
        AppData.sharedData.getUserData() != nil
    }
    
    weak var delegate: LoginRplusDelegate?
    
    init(delegate: LoginRplusDelegate) {
        self.delegate = delegate
    }
    
    func requestLoginRplus(body: [String]) {
        
            
            LoginRplusWS().postLoginRplus(body: body, completion: { (dataResponse, error) in
                
                guard error == nil else {
                    self.delegate?.loginRplusRequestCompleted(with: error?.localizedDescription ?? "error desconocido")
                    return
                }
                
                guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.errorTransaccion.rawValue else {
                    
                    // check for WS errors
                    switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                        case .errorTransaccion:
                             self.delegate?.loginRplusRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                        case .inicioSesionExitoso:
                             self.delegate?.loginRplusRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                        case .usuarioNoAutorizado:
                             self.delegate?.loginRplusRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                        case .errorValidarDatos:
                             self.delegate?.loginRplusRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                        case .registroExitoso:
                             self.delegate?.loginRplusRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                        case .actualizacionExitosa:
                             self.delegate?.loginRplusRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                        case .recuperacionListaRegistroExitosa:
                             self.delegate?.loginRplusRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                        case .eliminacionExitosa:
                             self.delegate?.loginRplusRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                        case .recuperacionRegistroExitoso:
                             self.delegate?.loginRplusRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                        case .registroNoEncontrado:
                             self.delegate?.loginRplusRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                        case .errorEliminacionRegistro:
                             self.delegate?.loginRplusRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                        case .exitoCerrarSesion:
                             self.delegate?.loginRplusRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                        case .usuarioNoExiste:
                             self.delegate?.loginRplusRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                        default:
                             self.delegate?.loginRplusRequestCompleted(with: "Error no encontrado")
                    }
                    
                    print("ERRORORE")
                    return
                }
                
                
                print("respuesta WS ----> \(dataResponse?.data?[0].token ?? "")")
                
                // MARK: setting model
                guard let data = dataResponse else {
                    self.delegate?.loginRplusRequestCompleted(with: "Token no encontrado")
                    return
                }
                self.assignData(with: data)
                self.delegate?.loginRplusRequestCompleted()
                
                
            })
        
    }
    
    private func assignData(with data: LoginRplus) {
        AppData.sharedData.allUserData = data
    }
    
}

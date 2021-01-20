//
//  TipoAreaComunViewModel.swift
//  rplusapp
//
//  Created by Josué López on 11/26/20.
//

import UIKit

protocol TipoAreaComunDelegate: class {
    func tipoAreaComunRequestCompleted()
    func tipoAreaComunRequestCompleted(with error: String)
}

struct TipoAreaComunViewModel {
    
    weak var delegate: TipoAreaComunDelegate?
    
    init(delegate: TipoAreaComunDelegate) {
        self.delegate = delegate
    }
    
    func requestTipoAreaComun() {
        
            
            TipoAreaComunWS().getTipoAreaComunList(completion: { (dataResponse, error) in
                
                print("\(dataResponse ?? .init())")
                guard error == nil else {
                    self.delegate?.tipoAreaComunRequestCompleted(with: error?.localizedDescription ?? "error desconocido")
                    return
                }
                
                print("errorCode \(dataResponse?.errorCode) \(dataResponse?.message)")
                
                guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.actualizacionExitosa.rawValue else {
                    
                    // check for WS errors
                    switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                        case .errorTransaccion:
                             self.delegate?.tipoAreaComunRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                        case .inicioSesionExitoso:
                             self.delegate?.tipoAreaComunRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                        case .usuarioNoAutorizado:
                             self.delegate?.tipoAreaComunRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                        case .errorValidarDatos:
                             self.delegate?.tipoAreaComunRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                        case .registroExitoso:
                             self.delegate?.tipoAreaComunRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                        case .actualizacionExitosa:
                             self.delegate?.tipoAreaComunRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                        case .recuperacionListaRegistroExitosa:
                             self.delegate?.tipoAreaComunRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                        case .eliminacionExitosa:
                             self.delegate?.tipoAreaComunRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                        case .recuperacionRegistroExitoso:
                             self.delegate?.tipoAreaComunRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                        case .registroNoEncontrado:
                             self.delegate?.tipoAreaComunRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                        case .errorEliminacionRegistro:
                             self.delegate?.tipoAreaComunRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                        case .exitoCerrarSesion:
                             self.delegate?.tipoAreaComunRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                        case .usuarioNoExiste:
                             self.delegate?.tipoAreaComunRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                        default:
                             self.delegate?.tipoAreaComunRequestCompleted(with: "Error no encontrado")
                    }
                    
                    print("ERRORORE")
                    return
                }
                
                
                // MARK: setting model
                GlobalParameters.instance().globalDataTipoAreaComun = dataResponse?.data ?? .init()
                self.delegate?.tipoAreaComunRequestCompleted()
                
                
            })
        
    }
    
}

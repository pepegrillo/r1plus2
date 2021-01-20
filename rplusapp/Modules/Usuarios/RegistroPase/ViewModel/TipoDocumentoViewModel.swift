//
//  TipoDocumentoViewModel.swift
//  rplusapp
//
//  Created by Josué López on 11/27/20.
//

import UIKit

protocol TipoDocumentoDelegate: class {
    func tipoDocumentoRequestCompleted()
    func tipoDocumentoRequestCompleted(with error: String)
}

struct TipoDocumentoViewModel {
    
    weak var delegate: TipoDocumentoDelegate?
    
    init(delegate: TipoDocumentoDelegate) {
        self.delegate = delegate
    }
    
    func requestTipoDocumento() {
        
            
            TipoDocumentoWS().getTipoDocumentoList(completion: { (dataResponse, error) in
                
                print("\(dataResponse ?? .init())")
                guard error == nil else {
                    self.delegate?.tipoDocumentoRequestCompleted(with: error?.localizedDescription ?? "error desconocido")
                    return
                }
                
                print("errorCode \(dataResponse?.errorCode) \(dataResponse?.message)")
                
                guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.actualizacionExitosa.rawValue else {
                    
                    // check for WS errors
                    switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                        case .errorTransaccion:
                             self.delegate?.tipoDocumentoRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                        case .inicioSesionExitoso:
                             self.delegate?.tipoDocumentoRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                        case .usuarioNoAutorizado:
                             self.delegate?.tipoDocumentoRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                        case .errorValidarDatos:
                             self.delegate?.tipoDocumentoRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                        case .registroExitoso:
                             self.delegate?.tipoDocumentoRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                        case .actualizacionExitosa:
                             self.delegate?.tipoDocumentoRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                        case .recuperacionListaRegistroExitosa:
                             self.delegate?.tipoDocumentoRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                        case .eliminacionExitosa:
                             self.delegate?.tipoDocumentoRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                        case .recuperacionRegistroExitoso:
                             self.delegate?.tipoDocumentoRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                        case .registroNoEncontrado:
                             self.delegate?.tipoDocumentoRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                        case .errorEliminacionRegistro:
                             self.delegate?.tipoDocumentoRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                        case .exitoCerrarSesion:
                             self.delegate?.tipoDocumentoRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                        case .usuarioNoExiste:
                             self.delegate?.tipoDocumentoRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                        default:
                             self.delegate?.tipoDocumentoRequestCompleted(with: "Error no encontrado")
                    }
                    
                    print("ERRORORE")
                    return
                }
                
                
                // MARK: setting model
                GlobalParameters.instance().globalDataTipoDocumento = dataResponse?.data ?? .init()
                self.delegate?.tipoDocumentoRequestCompleted()
                
                
            })
        
    }
    
}

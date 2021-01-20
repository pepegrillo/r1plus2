//
//  AmenidadViewModel.swift
//  rplusapp
//
//  Created by Josué López on 12/7/20.
//

import UIKit

protocol AmenidadDelegate: class {
    func amenidadRequestCompleted()
    func amenidadRequestCompleted(with error: String)
}

struct AmenidadViewModel {
    
    weak var delegate: AmenidadDelegate?
    
    init(delegate: AmenidadDelegate) {
        self.delegate = delegate
    }
    
    func requestAmenidad(body: [String]) {
        
            
        AmenidadesWS().postAmenidades(body: body, completion: { (dataResponse, error) in
                
                print("\(dataResponse ?? .init())")
                guard error == nil else {
                    self.delegate?.amenidadRequestCompleted(with: error?.localizedDescription ?? "error desconocido")
                    return
                }
                
            print("errorCode \(String(describing: dataResponse?.errorCode)) \(dataResponse?.message)")
                
                guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.errorValidarDatos.rawValue else {
                    
                    // check for WS errors
                    switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                        case .errorTransaccion:
                             self.delegate?.amenidadRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                        case .inicioSesionExitoso:
                             self.delegate?.amenidadRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                        case .usuarioNoAutorizado:
                             self.delegate?.amenidadRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                        case .errorValidarDatos:
                             self.delegate?.amenidadRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                        case .registroExitoso:
                             self.delegate?.amenidadRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                        case .actualizacionExitosa:
                             self.delegate?.amenidadRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                        case .recuperacionListaRegistroExitosa:
                             self.delegate?.amenidadRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                        case .eliminacionExitosa:
                             self.delegate?.amenidadRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                        case .recuperacionRegistroExitoso:
                             self.delegate?.amenidadRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                        case .registroNoEncontrado:
                             self.delegate?.amenidadRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                        case .errorEliminacionRegistro:
                             self.delegate?.amenidadRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                        case .exitoCerrarSesion:
                             self.delegate?.amenidadRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                        case .usuarioNoExiste:
                             self.delegate?.amenidadRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                        default:
                             self.delegate?.amenidadRequestCompleted(with: "Error no encontrado")
                    }
                    
                    print("ERRORORE")
                    return
                }
                
                
                // MARK: setting model
                self.delegate?.amenidadRequestCompleted()
                
                
            })
        
    }
    
}


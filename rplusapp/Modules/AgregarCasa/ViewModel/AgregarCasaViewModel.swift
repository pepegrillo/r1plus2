//
//  AgregarCasaViewModel.swift
//  rplusapp
//
//  Created by Josué López on 11/25/20.
//

import UIKit

protocol AgregarCasaDelegate: class {
    func agregarCasaCompleted()
    func agregarCasaCompleted(with error: String)
}

struct AgregarCasaViewModel {
    
    weak var delegate: AgregarCasaDelegate?
    
    init(delegate: AgregarCasaDelegate) {
        self.delegate = delegate
    }
    
    func requestAgregarCasa(body: [String]) {
        
        AgregarCasaWS().postAgregarCasa(body: body, completion: { (dataResponse, error) in
            
            print("------> \(dataResponse ?? .init())")
            
            guard error == nil else {
                self.delegate?.agregarCasaCompleted(with: error?.localizedDescription ?? "error desconocido")
                return
            }
            guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.errorValidarDatos.rawValue else {
                
                // check for WS errors
                switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                    case .errorTransaccion:
                         self.delegate?.agregarCasaCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                    case .inicioSesionExitoso:
                         self.delegate?.agregarCasaCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                    case .usuarioNoAutorizado:
                         self.delegate?.agregarCasaCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                    case .errorValidarDatos:
                         self.delegate?.agregarCasaCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                    case .registroExitoso:
                         self.delegate?.agregarCasaCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                    case .actualizacionExitosa:
                         self.delegate?.agregarCasaCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                    case .recuperacionListaRegistroExitosa:
                         self.delegate?.agregarCasaCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                    case .eliminacionExitosa:
                         self.delegate?.agregarCasaCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                    case .recuperacionRegistroExitoso:
                         self.delegate?.agregarCasaCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                    case .registroNoEncontrado:
                         self.delegate?.agregarCasaCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                    case .errorEliminacionRegistro:
                         self.delegate?.agregarCasaCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                    case .exitoCerrarSesion:
                         self.delegate?.agregarCasaCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                    case .usuarioNoExiste:
                         self.delegate?.agregarCasaCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                    default:
                         self.delegate?.agregarCasaCompleted(with: "Error no encontrado")
                }
                
                print("ERRORORE")
                return
            }
            
            // MARK: setting model
            self.delegate?.agregarCasaCompleted()
                
        })
    }
    
}

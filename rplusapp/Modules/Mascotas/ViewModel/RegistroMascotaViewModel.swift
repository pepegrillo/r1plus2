//
//  RegistroMascotaViewModel.swift
//  rplusapp
//
//  Created by Josué López on 12/1/20.
//

import UIKit

protocol RegistroMascotaDelegate: class {
    func registroMascotaCompleted()
    func registroMascotaCompleted(with error: String)
}

struct RegistroMascotaViewModel {
    
    weak var delegate: RegistroMascotaDelegate?
    
    init(delegate: RegistroMascotaDelegate) {
        self.delegate = delegate
    }
    
    func requestRegistroMascota(body: [String]) {
        
        RegistroMascotaWS().postRegistroMascota(body: body, completion: { (dataResponse, error) in
            
            print("------> \(dataResponse ?? .init())")
            
            guard error == nil else {
                self.delegate?.registroMascotaCompleted(with: error?.localizedDescription ?? "error desconocido")
                return
            }
            guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.errorValidarDatos.rawValue else {
                
                // check for WS errors
                switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                    case .errorTransaccion:
                         self.delegate?.registroMascotaCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                    case .inicioSesionExitoso:
                         self.delegate?.registroMascotaCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                    case .usuarioNoAutorizado:
                         self.delegate?.registroMascotaCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                    case .errorValidarDatos:
                         self.delegate?.registroMascotaCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                    case .registroExitoso:
                         self.delegate?.registroMascotaCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                    case .actualizacionExitosa:
                         self.delegate?.registroMascotaCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                    case .recuperacionListaRegistroExitosa:
                         self.delegate?.registroMascotaCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                    case .eliminacionExitosa:
                         self.delegate?.registroMascotaCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                    case .recuperacionRegistroExitoso:
                         self.delegate?.registroMascotaCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                    case .registroNoEncontrado:
                         self.delegate?.registroMascotaCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                    case .errorEliminacionRegistro:
                         self.delegate?.registroMascotaCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                    case .exitoCerrarSesion:
                         self.delegate?.registroMascotaCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                    case .usuarioNoExiste:
                         self.delegate?.registroMascotaCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                    default:
                         self.delegate?.registroMascotaCompleted(with: "Error no encontrado")
                }
                
                print("ERRORORE")
                return
            }
            
            // MARK: setting model
            self.delegate?.registroMascotaCompleted()
                
        })
    }
    
}

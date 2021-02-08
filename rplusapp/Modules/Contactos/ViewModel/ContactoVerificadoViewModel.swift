//
//  ContactoVerificadoViewModel.swift
//  rplusapp
//
//  Created by Josue Lopez on 1/25/21.
//

import UIKit

protocol ContactoVerificadoDelegate: class {
    func contactoVerificadoCompleted()
    func contactoVerificadoCompleted(with error: String)
}

struct ContactoVerificadoViewModel {
    
    weak var delegate: ContactoVerificadoDelegate?
    
    init(delegate: ContactoVerificadoDelegate) {
        self.delegate = delegate
    }
    
    func requestPostContactosVerificados(body: [String]) {
        
        var contactosFromDB = [DataContactosVerificadosWs]()
        
        print("inicio")
        ContactosVerificadosWS().postContactosVerificados(body: body, completion: { (dataResponse, error) in
            
            guard error == nil else {
                self.delegate?.contactoVerificadoCompleted(with: error?.localizedDescription ?? "error desconocido")
                return
            }
            
            guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.eliminacionExitosa.rawValue else {
                
                // check for WS errors
                switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                    case .errorTransaccion:
                        self.delegate?.contactoVerificadoCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                    case .inicioSesionExitoso:
                         self.delegate?.contactoVerificadoCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                    case .usuarioNoAutorizado:
                         self.delegate?.contactoVerificadoCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                    case .errorValidarDatos:
                         self.delegate?.contactoVerificadoCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                    case .registroExitoso:
                         self.delegate?.contactoVerificadoCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                    case .actualizacionExitosa:
                         self.delegate?.contactoVerificadoCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                    case .recuperacionListaRegistroExitosa:
                         self.delegate?.contactoVerificadoCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                    case .eliminacionExitosa:
                         self.delegate?.contactoVerificadoCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                    case .recuperacionRegistroExitoso:
                         self.delegate?.contactoVerificadoCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                    case .registroNoEncontrado:
                         self.delegate?.contactoVerificadoCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                    case .errorEliminacionRegistro:
                         self.delegate?.contactoVerificadoCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                    case .exitoCerrarSesion:
                         self.delegate?.contactoVerificadoCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                    case .usuarioNoExiste:
                         self.delegate?.contactoVerificadoCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                    default:
                         self.delegate?.contactoVerificadoCompleted(with: "Error no encontrado")
                }
                
                print("ERRORORE")
                return
            }
            
            //setting model
            print("respuesta WS ----> \(String(describing: dataResponse))")
            //self.listArray.append(dataResponse ?? .init())
            
            contactosFromDB = dataResponse?.data ?? .init()
            
            //update contactos con banderas
            contactosFromDB.forEach {
                AppData.sharedData.updateContactosObject(paramPhone: $0.phoneLocal ?? "00", paramExiste: "\($0.existe ?? 0)", paramVerificado: "\($0.verificado ?? 0)", paramTipo: $0.tipo ?? "Sin definir")
            }
            
            self.delegate?.contactoVerificadoCompleted()
            
        })
    }
}



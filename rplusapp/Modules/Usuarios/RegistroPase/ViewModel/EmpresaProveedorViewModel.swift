//
//  EmpresaProveedorViewModel.swift
//  rplusapp
//
//  Created by Josué López on 11/26/20.
//

import UIKit

protocol EmpresaProveedorDelegate: class {
    func empresaProveedorRequestCompleted()
    func empresaProveedorRequestCompleted(with error: String)
}

struct EmpresaProveedorViewModel {
    
    weak var delegate: EmpresaProveedorDelegate?
    
    init(delegate: EmpresaProveedorDelegate) {
        self.delegate = delegate
    }
    
    func requestEmpresaProveedor() {
        
            
            EmpresaProveedorWS().getEmpresaProveedorList(completion: { (dataResponse, error) in
                
                print("\(dataResponse ?? .init())")
                guard error == nil else {
                    self.delegate?.empresaProveedorRequestCompleted(with: error?.localizedDescription ?? "error desconocido")
                    return
                }
                
                print("errorCode \(dataResponse?.errorCode) \(dataResponse?.message)")
                
                guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.actualizacionExitosa.rawValue else {
                    
                    // check for WS errors
                    switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                        case .errorTransaccion:
                             self.delegate?.empresaProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                        case .inicioSesionExitoso:
                             self.delegate?.empresaProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                        case .usuarioNoAutorizado:
                             self.delegate?.empresaProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                        case .errorValidarDatos:
                             self.delegate?.empresaProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                        case .registroExitoso:
                             self.delegate?.empresaProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                        case .actualizacionExitosa:
                             self.delegate?.empresaProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                        case .recuperacionListaRegistroExitosa:
                             self.delegate?.empresaProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                        case .eliminacionExitosa:
                             self.delegate?.empresaProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                        case .recuperacionRegistroExitoso:
                             self.delegate?.empresaProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                        case .registroNoEncontrado:
                             self.delegate?.empresaProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                        case .errorEliminacionRegistro:
                             self.delegate?.empresaProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                        case .exitoCerrarSesion:
                             self.delegate?.empresaProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                        case .usuarioNoExiste:
                             self.delegate?.empresaProveedorRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                        default:
                             self.delegate?.empresaProveedorRequestCompleted(with: "Error no encontrado")
                    }
                    
                    print("ERRORORE")
                    return
                }
                
                
                // MARK: setting model
                GlobalParameters.instance().globalDataEmpresaProveedor = dataResponse?.data ?? .init()
                self.delegate?.empresaProveedorRequestCompleted()
                
                
            })
        
    }
    
}

//
//  EmpleadoDetalleViewModel.swift
//  rplusapp
//
//  Created by Josué López on 12/4/20.
//

import UIKit

protocol EmpleadoDetalleViewModelDelegate: class {
    func empleadoDetalleViewModelRequestCompleted()
    func empleadoDetalleViewModelRequestCompleted(with error: String)
}

class EmpleadoDetalleViewModel {
    
    weak var delegate: EmpleadoDetalleViewModelDelegate?
    
    init(delegate: EmpleadoDetalleViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Get WS
    func requestGetEmpleadoDetalle(paramIdEmpleado: Int) {
        
        print("inicio")
        EmpleadoDetalleWS().getEmpleadoDetalle(idEmpleadoDetalle: paramIdEmpleado, completion: { (dataResponse, error) in
            
            guard error == nil else {
                self.delegate?.empleadoDetalleViewModelRequestCompleted(with: error?.localizedDescription ?? "error desconocido")
                return
            }
            
            guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.eliminacionExitosa.rawValue else {
                
                // check for WS errors
                switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                    case .errorTransaccion:
                         self.delegate?.empleadoDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                    case .inicioSesionExitoso:
                         self.delegate?.empleadoDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                    case .usuarioNoAutorizado:
                         self.delegate?.empleadoDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                    case .errorValidarDatos:
                         self.delegate?.empleadoDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                    case .registroExitoso:
                         self.delegate?.empleadoDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                    case .actualizacionExitosa:
                         self.delegate?.empleadoDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                    case .recuperacionListaRegistroExitosa:
                         self.delegate?.empleadoDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                    case .eliminacionExitosa:
                         self.delegate?.empleadoDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                    case .recuperacionRegistroExitoso:
                         self.delegate?.empleadoDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                    case .registroNoEncontrado:
                         self.delegate?.empleadoDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                    case .errorEliminacionRegistro:
                         self.delegate?.empleadoDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                    case .exitoCerrarSesion:
                         self.delegate?.empleadoDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                    case .usuarioNoExiste:
                         self.delegate?.empleadoDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                    default:
                         self.delegate?.empleadoDetalleViewModelRequestCompleted(with: "Error no encontrado")
                }
                
                print("ERRORORE")
                return
            }
            
            
            print("respuesta WS ----> \(String(describing: dataResponse))")
            
            // MARK: setting model
            GlobalParameters.instance().globalDataEmpleadoDetalle = dataResponse?.data ?? .init()
            self.delegate?.empleadoDetalleViewModelRequestCompleted()
            
        })
    }
}

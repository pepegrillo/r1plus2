//
//  VisitaDetalleViewModel.swift
//  rplusapp
//
//  Created by Desarrollo on 2/17/21.
//

import UIKit

protocol VisitaDetalleDelegate: class {
    func visitaDetalleRequestCompleted()
    func visitaDetalleRequestCompleted(with error: String)
}

struct VisitaDetalleViewModel {
    
    weak var delegate: VisitaDetalleDelegate?
    
    init(delegate: VisitaDetalleDelegate) {
        self.delegate = delegate
    }
    
    func requestVisitaDetalle(paramDetalle: Int) {
        
        
        VisitaFrecuenteWS().getVisitaFrecuenteDetalle(idDetalle: paramDetalle, completion: { (dataResponse, error) in
            
            print("\(dataResponse ?? .init())")
            guard error == nil else {
                self.delegate?.visitaDetalleRequestCompleted(with: error?.localizedDescription ?? "error desconocido")
                return
            }
            
            print("errorCode \(String(describing: dataResponse?.errorCode)) \(String(describing: dataResponse?.message))")
            
            guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.eliminacionExitosa.rawValue else {
                
                // check for WS errors
                switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                case .errorTransaccion:
                    self.delegate?.visitaDetalleRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                case .inicioSesionExitoso:
                    self.delegate?.visitaDetalleRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                case .usuarioNoAutorizado:
                    self.delegate?.visitaDetalleRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                case .errorValidarDatos:
                    self.delegate?.visitaDetalleRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                case .registroExitoso:
                    self.delegate?.visitaDetalleRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                case .actualizacionExitosa:
                    self.delegate?.visitaDetalleRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                case .recuperacionListaRegistroExitosa:
                    self.delegate?.visitaDetalleRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                case .eliminacionExitosa:
                    self.delegate?.visitaDetalleRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                case .recuperacionRegistroExitoso:
                    self.delegate?.visitaDetalleRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                case .registroNoEncontrado:
                    self.delegate?.visitaDetalleRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                case .errorEliminacionRegistro:
                    self.delegate?.visitaDetalleRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                case .exitoCerrarSesion:
                    self.delegate?.visitaDetalleRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                case .usuarioNoExiste:
                    self.delegate?.visitaDetalleRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                default:
                    self.delegate?.visitaDetalleRequestCompleted(with: "Error no encontrado")
                }
                
                print("ERRORORE")
                return
            }
            
            
            // MARK: setting model
            GlobalParameters.instance().globalDataVisitaDetalle = dataResponse?.data ?? .init()
            self.delegate?.visitaDetalleRequestCompleted()
            
            
        })
        
    }
    
}


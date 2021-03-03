//
//  ReporteDetalleViewModel.swift
//  rplusapp
//
//  Created by Josue Lopez Desarrollo on 3/3/21.
//

import UIKit

protocol ReporteDetalleViewModelDelegate: class {
    func reporteDetalleViewModelRequestCompleted()
    func reporteDetalleViewModelRequestCompleted(with error: String)
}

class ReporteDetalleViewModel {
    
    weak var delegate: ReporteDetalleViewModelDelegate?
    
    init(delegate: ReporteDetalleViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Get WS
    func requestGetReporteDetalle(paramIdReporte: Int) {
        
        print("inicio")
        ReporteWS().getReporteDetalle(idReporte: paramIdReporte, completion: { (dataResponse, error) in
            
            guard error == nil else {
                self.delegate?.reporteDetalleViewModelRequestCompleted(with: error?.localizedDescription ?? "error desconocido")
                return
            }
            
            guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.eliminacionExitosa.rawValue else {
                
                // check for WS errors
                switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                    case .errorTransaccion:
                         self.delegate?.reporteDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                    case .inicioSesionExitoso:
                         self.delegate?.reporteDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                    case .usuarioNoAutorizado:
                         self.delegate?.reporteDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                    case .errorValidarDatos:
                         self.delegate?.reporteDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                    case .registroExitoso:
                         self.delegate?.reporteDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                    case .actualizacionExitosa:
                         self.delegate?.reporteDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                    case .recuperacionListaRegistroExitosa:
                         self.delegate?.reporteDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                    case .eliminacionExitosa:
                         self.delegate?.reporteDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                    case .recuperacionRegistroExitoso:
                         self.delegate?.reporteDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                    case .registroNoEncontrado:
                         self.delegate?.reporteDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                    case .errorEliminacionRegistro:
                         self.delegate?.reporteDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                    case .exitoCerrarSesion:
                         self.delegate?.reporteDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                    case .usuarioNoExiste:
                         self.delegate?.reporteDetalleViewModelRequestCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                    default:
                         self.delegate?.reporteDetalleViewModelRequestCompleted(with: "Error no encontrado")
                }
                
                print("ERRORORE")
                return
            }
            
            
            print("respuesta WS ----> \(String(describing: dataResponse))")
            
            // MARK: setting model
            GlobalParameters.instance().globalDataReporteDetalle = dataResponse?.data ?? .init()
            self.delegate?.reporteDetalleViewModelRequestCompleted()
            
        })
    }
}

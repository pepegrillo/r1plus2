//
//  SectorViewModel.swift
//  rplusapp
//
//  Created by Josué López on 11/25/20.
//

import UIKit

protocol SectorDelegate: class {
    func sectorCompleted()
    func sectorCompleted(with error: String)
}

struct SectorViewModel {
    
    weak var delegate: SectorDelegate?
    
    init(delegate: SectorDelegate) {
        self.delegate = delegate
    }
    
    func requestSector() {
        
        AgregarCasaWS().getSectorList(completion: { (dataResponse, error) in
            
            print("------> \(dataResponse)")
            
            guard error == nil else {
                self.delegate?.sectorCompleted(with: error?.localizedDescription ?? "error desconocido")
                return
            }
            guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.actualizacionExitosa.rawValue else {
                
                // check for WS errors
                switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                    case .errorTransaccion:
                         self.delegate?.sectorCompleted(with: "\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                    case .inicioSesionExitoso:
                         self.delegate?.sectorCompleted(with: "\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                    case .usuarioNoAutorizado:
                         self.delegate?.sectorCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                    case .errorValidarDatos:
                         self.delegate?.sectorCompleted(with: "\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                    case .registroExitoso:
                         self.delegate?.sectorCompleted(with: "\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                    case .actualizacionExitosa:
                         self.delegate?.sectorCompleted(with: "\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                    case .recuperacionListaRegistroExitosa:
                         self.delegate?.sectorCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                    case .eliminacionExitosa:
                         self.delegate?.sectorCompleted(with: "\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                    case .recuperacionRegistroExitoso:
                         self.delegate?.sectorCompleted(with: "\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                    case .registroNoEncontrado:
                         self.delegate?.sectorCompleted(with: "\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                    case .errorEliminacionRegistro:
                         self.delegate?.sectorCompleted(with: "\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                    case .exitoCerrarSesion:
                         self.delegate?.sectorCompleted(with: "\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                    case .usuarioNoExiste:
                         self.delegate?.sectorCompleted(with: "\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                    default:
                         self.delegate?.sectorCompleted(with: "Error no encontrado")
                }
                
                print("ERRORORE")
                return
            }
            
            // MARK: setting model
            GlobalParameters.instance().globalDataSector = dataResponse?.data ?? .init()
            self.delegate?.sectorCompleted()
                
        })
    }
    
}

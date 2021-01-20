//
//  VisitaFrecuenteViewModel.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

import UIKit

class VisitaFrecuenteViewModel {
    
    // Closure notification
    var reloadList = {() -> () in }
    var errorMessage = {(message : String) -> () in }
    
    //Array of Winner Model class
    var listArray : [DataVisitaFrecuente] = []{
        //Reload data when data set
        didSet{
            reloadList()
        }
    }
    
    func requestGetVisitaFrecuente(paramTypeUrl: Int? = 0) {
        print("inicio")
        VisitaFrecuenteWS().getVisitaFrecuenteListByLimit(idTypeURL: paramTypeUrl ?? 0, completion: { (dataResponse, error) in
            
            guard error == nil else {
                self.errorMessage(error?.localizedDescription ?? "error desconocido")
                return
            }
            
            guard let errorCode = dataResponse?.errorCode, errorCode == ErrorResponse.errorResponseCode.actualizacionExitosa.rawValue else {
                
                // check for WS errors
                switch ErrorResponse.errorResponseCode(rawValue: dataResponse?.errorCode ?? 1) {
                    case .errorTransaccion:
                         self.errorMessage("\(ErrorResponse.errorResponseMessage.errorTransaccion.rawValue)")
                    case .inicioSesionExitoso:
                         self.errorMessage("\(ErrorResponse.errorResponseMessage.inicioSesionExitoso.rawValue)")
                    case .usuarioNoAutorizado:
                         self.errorMessage("\(ErrorResponse.errorResponseMessage.usuarioNoAutorizado.rawValue)")
                    case .errorValidarDatos:
                         self.errorMessage("\(ErrorResponse.errorResponseMessage.errorValidarDatos.rawValue)")
                    case .registroExitoso:
                         self.errorMessage("\(ErrorResponse.errorResponseMessage.registroExitoso.rawValue)")
                    case .actualizacionExitosa:
                         self.errorMessage("\(ErrorResponse.errorResponseMessage.actualizacionExitosa.rawValue)")
                    case .recuperacionListaRegistroExitosa:
                         self.errorMessage("\(ErrorResponse.errorResponseMessage.recuperacionListaRegistroExitosa.rawValue)")
                    case .eliminacionExitosa:
                         self.errorMessage("\(ErrorResponse.errorResponseMessage.eliminacionExitosa.rawValue)")
                    case .recuperacionRegistroExitoso:
                         self.errorMessage("\(ErrorResponse.errorResponseMessage.recuperacionRegistroExitoso.rawValue)")
                    case .registroNoEncontrado:
                         self.errorMessage("\(ErrorResponse.errorResponseMessage.registroNoEncontrado.rawValue)")
                    case .errorEliminacionRegistro:
                         self.errorMessage("\(ErrorResponse.errorResponseMessage.errorEliminacionRegistro.rawValue)")
                    case .exitoCerrarSesion:
                         self.errorMessage("\(ErrorResponse.errorResponseMessage.exitoCerrarSesion.rawValue)")
                    case .usuarioNoExiste:
                         self.errorMessage("\(ErrorResponse.errorResponseMessage.usuarioNoExiste.rawValue)")
                    default:
                         self.errorMessage("Error no encontrado")
                }
                
                print("ERRORORE")
                return
            }
            
            //array viene vacio pero retirna exitoso
            guard dataResponse?.data?.isEmpty == false else {
                self.errorMessage("Error no encontrado")
                return
            }
            
            //setting model
            print("respuesta WS ----> \(String(describing: dataResponse))")
            self.listArray.removeAll()
            self.listArray.append(contentsOf: (dataResponse?.data!)!)
            
        })
    }
    

}

//
//  ResidencialViewModel.swift
//  rplusapp
//
//  Created by Josué López on 11/17/20.
//

import UIKit

class ResidencialViewModel {
    
    // Closure notification
    var reloadList = {() -> () in }
    var errorMessage = {(message : String) -> () in }
    
    //Array of Winner Model class
    var listArray : [DataResidencial] = []{
        //Reload data when data set
        didSet{
            reloadList()
        }
    }
    
    func requestGetResidencial() {
        print("inicio")
        ResidencialWS().getResidencialList(completion: { (dataResponse, error) in
            
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
            
            //setting model
            print("respuesta WS ----> \(dataResponse)")
            self.listArray.append(contentsOf: (dataResponse?.data!)!)
            
        })
    }
    
}

//
//  GlobalParameters.swift
//  rplusapp
//
//  Created by Josué López on 11/18/20.
//

import UIKit

class GlobalParameters {
    
    private static var globalVariableInformation : GlobalParameters? = nil

    //array from lists
    var globalDataPerfil = [DataPerfil]()
    var globalDataTipoUsuario = [DataTipoUsuario]()
    
    var globalDataSector = [DataSector]()
    var globalDataUbicacionPorSector = [DataUbicacion]()
    var globalDataViviendaPorUbicacion = [DataVivienda]()
    var globalDataTipoAreaComun = [DataTipoAreaComun]()
    var globalDataEmpresaProveedor = [DataEmpresaProveedor]()
    var globalDataTipoDocumento = [DataTipoDocumento]()
    var globalDataPerfilMascota = [DataPerfilMascota]()
    var globalDataTipoMascota = [DataTipoMascota]()
    var globalDataEmpleadoDetalle = [DataEmpleadoDetalle]()
    var globalDataVisitaDetalle = [DataVisitaFrecuenteDetalle]()
    
    //apple signin
    var globalAppleName: String = ""
    var globalAppleEmail: String = ""
    
//    var starSac = DetalleSac()
    
    
    static func instance() -> GlobalParameters {
        if (globalVariableInformation == nil) {
            globalVariableInformation = GlobalParameters()
        }
        return globalVariableInformation!
    }
    
    private init() {
        
    }
    
}


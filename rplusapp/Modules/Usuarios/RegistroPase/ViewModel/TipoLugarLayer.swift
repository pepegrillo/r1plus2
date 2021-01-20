//
//  TipoLugarLayer.swift
//  rplusapp
//
//  Created by Josué López on 11/26/20.
//

import Foundation

enum TipoLugarLayer {
    case casa
    case areaComun
    
    var name: String {
        switch self {
            case .casa:
                return "Mi casa"
            case .areaComun:
                return "Area en comun"
            
        }
    }
    
    var value: String {
        switch self {
            case .casa:
                return "0"
            case .areaComun:
                return "1"
            
        }
    }
}

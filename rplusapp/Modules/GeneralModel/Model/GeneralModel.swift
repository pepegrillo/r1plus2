//
//  GeneralModel.swift
//  rplusapp
//
//  Created by Josué López on 11/25/20.
//

import UIKit

// MARK: - GeneralModel
struct GeneralModel: Codable {
    
    var success: Bool?
    var errorCode: Int?
    var message: String?
    
    init() {
        
    }
    
    init(attributes: [String: Any]) {
        self.success = attributes["success"] as? Bool
        self.errorCode = attributes["errorCode"] as? Int
        self.message = attributes["message"] as? String
        
    }
}

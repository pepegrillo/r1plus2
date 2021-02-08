//
//  GeneratorQR.swift
//  rplusapp
//
//  Created by Josue Lopez on 2/5/21.
//

import UIKit

class GeneratorQR {
    
    static let createGeneratorQR = GeneratorQR()
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
}

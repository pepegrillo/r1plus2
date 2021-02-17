//
//  PaseImageQRViewController.swift
//  rplusapp
//
//  Created by Desarrollo on 2/16/21.
//

import UIKit

class PaseImageQRViewController: UIViewController {
    
    @IBOutlet weak var imageQR: UIImageView!
    @IBOutlet weak var lblCodigo: UILabel!
    var paramImageQR: String = ""
    
    override func viewDidLoad() {
        
        imageQR.image = GeneratorQR.createGeneratorQR.generateQRCode(from: paramImageQR )
        lblCodigo.text = paramImageQR
    }
    
    @IBAction func actionClose(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
}

//
//  PaseAsignadoDetalleViewController.swift
//  rplusapp
//
//  Created by Josué López on 12/11/20.
//

import UIKit

class PaseAsignadoDetalleViewController: UIViewController {
    
    @IBOutlet weak var lblCondominio: UILabel!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblTipoUsuario: UILabel!
    @IBOutlet weak var lblCasa: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblHora: UILabel!
    @IBOutlet weak var imageQR: UIImageView!
    
    var paramCondominio, paramNombre, paramTipoUsuario, paramCasa, paramFecha, paramHora, paramCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set design
        setScreenDesign()
        
        // set data
        fillData()
        
    }
    
    @IBAction func actionShowImageQR(_ sender: UIButton) {
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "PaseImageQRViewController") as! PaseImageQRViewController
        vc.paramImageQR = paramCode ?? ""
        self.present(vc, animated: true)
    }
}

extension PaseAsignadoDetalleViewController {
    
    private func setScreenDesign() {
        
        imageQR.image = GeneratorQR.createGeneratorQR.generateQRCode(from: paramCode ?? "")
    }
    
    private func fillData() {
        
        lblCondominio.text = paramCondominio
        lblNombre.text = paramNombre
        lblTipoUsuario.text = paramTipoUsuario
        lblCasa.text = paramCasa
        lblFecha.text = paramFecha
        lblHora.text = paramHora
    }
}

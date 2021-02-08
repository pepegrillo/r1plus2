//
//  PerfilGenericoViewController.swift
//  rplusapp
//
//  Created by Josué López on 12/11/20.
//

import UIKit

class PerfilGenericoViewController: UIViewController {
    
    @IBOutlet weak var imageAvatar: UIImageView!
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var containerForm1: UIView!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblHora: UILabel!
    
    var paramTipoPerfil = ""
    
    var paramLogo, paramNombre, paramFecha, paramHora: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set screen design
        setScreenDesign()
        
        //fillData
        fillData()
        
    }
}

extension PerfilGenericoViewController {
    
    private func setScreenDesign() {
        
        imageAvatar.makeRounded()
        
        if paramTipoPerfil != "proveedor" {
            containerForm1.isHidden = true
        }
    }
    
    private func fillData() {
        
        lblNombre.text = paramNombre
        
        if paramTipoPerfil == "proveedor" {
            imageAvatar.sd_setImage(with: URL(string: paramLogo ?? ""), placeholderImage: UIImage(named:Constants.App.imagePlaceholder))
            
            
            lblFecha.text = paramFecha
            lblHora.text = paramHora
        }
    }
}

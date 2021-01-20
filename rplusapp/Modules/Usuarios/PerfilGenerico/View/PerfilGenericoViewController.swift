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
    @IBOutlet weak var lblPhone: UILabel!
    
    var paramTipoPerfil = ""
    
    var paramLogo, paramNombre, paramPhone: String?
    
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
            
            
            lblPhone.text = paramPhone
        }
    }
}

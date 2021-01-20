//
//  MiPerfilViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/19/20.
//

import UIKit

class MiPerfilViewController: UIViewController {
    
    @IBOutlet weak var imageAvatar: UIImageView!
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblCondominio: UILabel!
    @IBOutlet weak var lblCasa: UILabel!
    @IBOutlet weak var lblTipoUsuario: UILabel!
    
    @IBOutlet weak var lblCorreo: UILabel!
    @IBOutlet weak var lblTelefono1: UILabel!
    @IBOutlet weak var lblTelefono2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: fillData
        fillData()
        
        //set design
        setDesign()
    }
}

extension MiPerfilViewController {
    
    private func setDesign() {
        
        self.imageAvatar.makeRounded()
        
    }
    
    private func fillData() {
        
        let fillPerfil = GlobalParameters.instance().globalDataPerfil
        
        print(fillPerfil.count)
        
        guard (fillPerfil.count == 0) else {
            
            imageAvatar.sd_setImage(with: URL(string: "\(fillPerfil[0].avatar ?? "")"), placeholderImage: UIImage(named: Constants.App.imagePlaceholder))

            lblNombre.text = fillPerfil[0].nombre
            lblCondominio.text = fillPerfil[0].ubicacion
            lblCasa.text = fillPerfil[0].vivienda
            lblTipoUsuario.text = fillPerfil[0].tipoResidente

            lblCorreo.text = fillPerfil[0].correo

            lblTelefono1.text = fillPerfil[0].telefono?[safe: 0]?.phone
            lblTelefono2.text = fillPerfil[0].telefono?[safe: 1]?.phone == nil ? "--" : fillPerfil[0].telefono?[safe: 1]?.phone
            
            
            return
        }
        
        
    }
    
}

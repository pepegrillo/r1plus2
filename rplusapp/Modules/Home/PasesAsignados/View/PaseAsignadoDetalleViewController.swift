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
    
    var paramCondominio, paramNombre, paramTipoUsuario, paramCasa, paramFecha, paramHora: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set data
        fillData()
        
    }
}

extension PaseAsignadoDetalleViewController {
    
    private func fillData() {
        
        lblCondominio.text = paramCondominio
        lblNombre.text = paramNombre
        lblTipoUsuario.text = paramTipoUsuario
        lblCasa.text = paramCasa
        lblFecha.text = paramFecha
        lblHora.text = paramHora
    }
}

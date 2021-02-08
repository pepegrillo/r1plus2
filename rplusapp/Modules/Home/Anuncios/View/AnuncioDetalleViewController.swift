//
//  AnuncioDetalleViewController.swift
//  rplusapp
//
//  Created by Josue Lopez on 1/28/21.
//

import UIKit

class AnuncioDetalleViewController: UIViewController {
    
    @IBOutlet weak var imgAnuncio: UIImageView!
    @IBOutlet weak var lblVigencia: UILabel!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    
    var paramImage = "", paramVigencia = "", paramTitulo = "", paramDescripcion = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set design
        setDesign()
        
    }
}

extension AnuncioDetalleViewController {
    
    private func setDesign() {
        
        self.imgAnuncio.sd_setImage(with: URL(string: "\(paramImage)"), placeholderImage: UIImage(named: Constants.App.imagePlaceholder))
        self.imgAnuncio.cornerRadiusViewBorder(bcColor: .white, borderRadius: Constants.App.cornerRadiusView)
        self.lblVigencia.text = "Vigencia: \(paramVigencia)"
        self.lblTitulo.text = paramTitulo
        self.lblDescripcion.text = paramDescripcion
    }
}

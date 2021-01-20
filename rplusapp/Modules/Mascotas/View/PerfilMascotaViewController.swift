//
//  PerfilMascotaViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/19/20.
//

import UIKit

class PerfilMascotaViewController: UIViewController {
    
    // MARK: - Perfil Mascota Outlets
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var lblRaza: UILabel!
    @IBOutlet weak var btnEditarMascota: UIButton!
    
    @IBOutlet weak var lblResponsable: UILabel!
    @IBOutlet weak var lblCondominio: UILabel!
    @IBOutlet weak var lblCasa: UILabel!
    @IBOutlet weak var lblTelefono: UILabel!
    
    //parameter from pet detail
    var paramIdMascota = 0
    
    private var perfilMascotaViewModel: PerfilMascotaViewModel{
        PerfilMascotaViewModel(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
        
        //set design
        setDesign()
    }
}

extension PerfilMascotaViewController {
    
    private func setDesign() {
        
        self.imgAvatar.makeRounded()
        
        self.btnEditarMascota.customButton(bcColor: .white, borderRadius: Constants.App.cornerRadiusButton)
        
    }
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // MARK: perfil parameters
        perfilMascotaViewModel.requestGetPerfilMascota(paramIdMascota: paramIdMascota)
        
    }
    
}

// MARK: - Perfil Parameters
extension PerfilMascotaViewController: PerfilMascotaViewModelDelegate {
    func perfilMascotaViewModelRequestCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            
            let dataPerfil = GlobalParameters.instance().globalDataPerfilMascota
            
            self.imgAvatar.sd_setImage(with: URL(string: dataPerfil[0].photoPet ?? ""), placeholderImage: UIImage(named: Constants.App.imagePlaceholder))
            
            self.lblNombre.text = dataPerfil[0].name?.capitalized
            self.lblDescripcion.text = dataPerfil[0].description
            self.lblRaza.text = dataPerfil[0].breed
            
            self.lblResponsable.text = dataPerfil[0].responsable?.capitalized
            self.lblCondominio.text = dataPerfil[0].residencial?.capitalized
            self.lblCasa.text = dataPerfil[0].vivienda
            self.lblTelefono.text = dataPerfil[0].phone
            
        }
    }
    
    func perfilMascotaViewModelRequestCompleted(with error: String) {
        print("perfil con error")
        ActivityIndicator.sharedIndicator.hideActivityIndicator()
    }
    
    
}

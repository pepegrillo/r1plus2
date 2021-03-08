//
//  DetalleVisitasFrecuentesViewController.swift
//  rplusapp
//
//  Created by Josue Lopez on 2/13/21.
//

import UIKit

class DetalleVisitasFrecuentesViewController: UIViewController {
    
    @IBOutlet weak var imageQR: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblApellido: UILabel!
    @IBOutlet weak var lblTipoDeVisita: UILabel!
    @IBOutlet weak var btnCompartirQR: UIButton!
    
    @IBOutlet weak var lblTelefono: UILabel!
    @IBOutlet weak var lblCorreo: UILabel!
    @IBOutlet weak var lblLugar: UILabel!
    @IBOutlet weak var lblDocumento: UILabel!
    @IBOutlet weak var lblPlaca: UILabel!
    
    var paramID: Int = 0
    var image: UIImage?
    var shareCode: String = ""
    
    private var visitaDetalleViewModel: VisitaDetalleViewModel{
        VisitaDetalleViewModel(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set design
        setDesign()
        
        // init loading
        initialMethod()
        
    }
    
    @IBAction func actionShareImageQR(_ sender: UIButton) {
        
        if let imageX = image!.pngData() {
            let vc = UIActivityViewController(activityItems: [imageX, shareCode], applicationActivities: [])
            if #available(iOS 13.0, *) {
                vc.isModalInPresentation = true
            }
            present(vc, animated: true)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

extension DetalleVisitasFrecuentesViewController {
    
    private func setDesign() {
        
        self.btnCompartirQR.customButton(bcColor: Constants.PaletteColors.colorFirst, borderRadius: Constants.App.cornerRadiusButton)
        
    }
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // MARK: perfil parameters
        visitaDetalleViewModel.requestVisitaDetalle(paramDetalle: paramID)
        
    }
    
}

extension DetalleVisitasFrecuentesViewController: VisitaDetalleDelegate {
    func visitaDetalleRequestCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            
            let dataVisita = GlobalParameters.instance().globalDataVisitaDetalle
            
            self.shareCode = "https://rplus.latmobile.com/share/\(dataVisita[0].code ?? "")"
            self.image =  GeneratorQR.createGeneratorQR.generateQRCode(from: "\(dataVisita[0].code ?? "")")
            self.image = self.imageQR.image
            self.imageQR.image = self.image
            
            self.lblNombre.text = dataVisita[0].name?.capitalized
            self.lblApellido.text = dataVisita[0].lastName?.capitalized
            self.lblTipoDeVisita.text = "-"
            
            
            self.lblTelefono.text = dataVisita[0].phone
            self.lblCorreo.text = dataVisita[0].email
            self.lblLugar.text = "\(dataVisita[0].idLugar ?? 0)"
            self.lblDocumento.text = dataVisita[0].documentNumber
            self.lblPlaca.text = dataVisita[0].vehiclePlate
            
            
        }
    }
    
    func visitaDetalleRequestCompleted(with error: String) {
        print("empleado detalle con error")
        ActivityIndicator.sharedIndicator.hideActivityIndicator()
        AlertManager.showAlert(withMessage: "Pase no Encontrada", title: "Error")
    }
    
    
}

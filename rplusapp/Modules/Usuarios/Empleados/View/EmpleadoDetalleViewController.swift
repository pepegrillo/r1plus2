//
//  EmpleadoDetalleViewController.swift
//  rplusapp
//
//  Created by Josué López on 12/4/20.
//

import UIKit

class EmpleadoDetalleViewController: UIViewController {
    
    // MARK: - Perfil Empleado Outlets
    @IBOutlet weak var imgDuiFrente: UIImageView!
    @IBOutlet weak var imgDuiReverso: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblApellido: UILabel!
    @IBOutlet weak var lblDui: UILabel!
    @IBOutlet weak var lblTelefono: UILabel!
    
    //parameter from empleado detail
    var paramIdEmpleado = 0
    
    private var empleadoDetalleViewModel: EmpleadoDetalleViewModel{
        EmpleadoDetalleViewModel(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
        
    }
}

extension EmpleadoDetalleViewController {
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // MARK: perfil parameters
        empleadoDetalleViewModel.requestGetEmpleadoDetalle(paramIdEmpleado: paramIdEmpleado)
        
    }
    
}

extension EmpleadoDetalleViewController: EmpleadoDetalleViewModelDelegate {
    func empleadoDetalleViewModelRequestCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            
            let dataEmpleado = GlobalParameters.instance().globalDataEmpleadoDetalle
            
            self.imgDuiFrente.sd_setImage(with: URL(string: dataEmpleado[0].duiFrente ?? ""), placeholderImage: UIImage(named: Constants.App.imagePlaceholder))
            
            self.imgDuiReverso.sd_setImage(with: URL(string: dataEmpleado[0].duiReverso ?? ""), placeholderImage: UIImage(named: Constants.App.imagePlaceholder))
            
            self.lblNombre.text = dataEmpleado[0].nombre?.capitalized
            self.lblApellido.text = dataEmpleado[0].nombre
            
            
            self.lblTelefono.text = dataEmpleado[0].telefono?[0].phone
            
            
        }
    }
    
    func empleadoDetalleViewModelRequestCompleted(with error: String) {
        print("empleado detalle con error")
        ActivityIndicator.sharedIndicator.hideActivityIndicator()
    }
    
    
}

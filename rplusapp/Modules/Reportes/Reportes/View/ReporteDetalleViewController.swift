//
//  ReporteDetalleViewController.swift
//  rplusapp
//
//  Created by Josue Lopez Desarrollo on 3/3/21.
//

import UIKit

class ReporteDetalleViewController: UIViewController {
    
    // MARK: - Detalle reporte Outlets
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblIngreso: UILabel!
    @IBOutlet weak var lblIngresoFecha: UILabel!
    @IBOutlet weak var lblIngresoHora: UILabel!
    @IBOutlet weak var lblProceso: UILabel!
    @IBOutlet weak var lblProcesoFecha: UILabel!
    @IBOutlet weak var lblProcesoHora: UILabel!
    @IBOutlet weak var lblFin: UILabel!
    @IBOutlet weak var lblFinFecha: UILabel!
    @IBOutlet weak var lblFinHora: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    
    //parameter from pet detail
    var paramIdReporte = 0
    
    private var perfilReporteDetalleViewModel: ReporteDetalleViewModel{
        ReporteDetalleViewModel(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
        
        //set design
        setDesign()
    }
}

extension ReporteDetalleViewController {
    
    private func setDesign() {
        
        navigationController?.navigationBar.barTintColor = Constants.PaletteColors.colorFirst
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.imgAvatar.makeRounded()
        
    }
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // MARK: perfil parameters
        perfilReporteDetalleViewModel.requestGetReporteDetalle(paramIdReporte: paramIdReporte)
        
    }
    
}

extension ReporteDetalleViewController: ReporteDetalleViewModelDelegate {
    func reporteDetalleViewModelRequestCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            
            let dataPerfil = GlobalParameters.instance().globalDataReporteDetalle
            
            self.imgAvatar.sd_setImage(with: URL(string: dataPerfil[0].alerta?.imgAlertaMovil ?? ""), placeholderImage: UIImage(named: Constants.App.imagePlaceholder))
            
            self.lblNombre.text = dataPerfil[0].alerta?.name
            self.lblDescripcion.text = dataPerfil[0].description
            
            dataPerfil[0].historial?.enumerated().forEach({ (index, item) in
                
                if (index == 0) {
                    self.lblIngresoFecha.text = "Fecha: \(dataPerfil[0].historial?[0].estado?.created_at ?? "--")"
                    self.lblIngresoHora.text = "Hora: \(dataPerfil[0].historial?[0].estado?.created_at ?? "-")"
                
                } else if (index == 1) {
                    self.lblProcesoFecha.text = "Fecha: \(dataPerfil[0].historial?[1].estado?.created_at ?? "--")"
                    self.lblProcesoHora.text = "Hora: \(dataPerfil[0].historial?[1].estado?.created_at ?? "--")"
                
                } else {
                    self.lblFinFecha.text = "Fecha: \(dataPerfil[0].historial?[2].estado?.created_at ?? "--")"
                    self.lblFinHora.text = "Fecha: \(dataPerfil[0].historial?[2].estado?.created_at ?? "--")"
                }
            })
            
            
            
            
        }
    }
    
    func reporteDetalleViewModelRequestCompleted(with error: String) {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
        }
    }
    
    
}

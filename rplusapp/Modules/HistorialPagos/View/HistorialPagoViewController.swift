//
//  HistorialPagoViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/30/20.
//

import UIKit

class HistorialPagoViewController: UIViewController {
    
    @IBOutlet weak var tvHistorialPago: UITableView!
    
    private var historialPagoViewModel = HistorialPagoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
    }
    
}

extension HistorialPagoViewController {
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // Tableview Set DataSource and DataDelegate
        tvHistorialPago.dataSource = self
        tvHistorialPago.delegate = self
        
        // Call pageSetup
        pageSetup()
    }
    
    // Initial page setup
    private func pageSetup()  {
        
        // callin g data perfil
        let fillPerfil = GlobalParameters.instance().globalDataPerfil
        
        guard (fillPerfil.count == 0) else {
            // Calling from viewmodel class
            historialPagoViewModel.requestGetHistorialPago(paramTelefono: "\(fillPerfil[0].telefono?[0].phone ?? "")")
            closureSetUp()
            return
        }
        
    }
    
    // Closure initialize
    func closureSetUp()  {
        historialPagoViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.tvHistorialPago.reloadData()
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
            
        }
        historialPagoViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print("ERROR VIEW --> \(message)")
                
                self?.tvHistorialPago.isHidden = true
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
        }
    }
}

extension HistorialPagoViewController: UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvHistorialPago.dequeueReusableCell(withIdentifier: "HistorialPagoCell", for: indexPath as IndexPath) as! HistorialPagoTableViewCell
        
        let data = historialPagoViewModel.listArray[indexPath.row]
        
        cell.container.cornerRadiusView(borderRadius: Constants.App.cornerRadiusView)
        if indexPath.row % 2 == 0 {
            cell.container.backgroundColor = Constants.PaletteColors.listBeneficioGray
            
        } else {
            cell.container.backgroundColor = Constants.PaletteColors.listBeneficioGreen
        }
        
        cell.lblName.text = data.concepto ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historialPagoViewModel.listArray.count
        
    }
}

extension HistorialPagoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = historialPagoViewModel.listArray[indexPath.row]
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "GeneralWebviewViewController") as! GeneralWebviewViewController
        vc.strTitle = data.concepto ?? ""
        vc.strURL = "\(data.link ?? "")"
        
        navigationController?.pushViewController(vc, animated: true)
        
        print("\(data.link ?? "")")
    }
    
}

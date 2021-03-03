//
//  MisReportesViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/20/20.
//

import UIKit

class MisReportesViewController: UIViewController {
    
    @IBOutlet weak var tvMisReportes: UITableView!
    
    private var misReportesViewModel = ReporteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
    }

}

extension MisReportesViewController {
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // Tableview Set DataSource and DataDelegate
        tvMisReportes.dataSource = self
        tvMisReportes.delegate = self
        
        // Call pageSetup
        pageSetup()
    }
    
    // Initial page setup
    private func pageSetup()  {
        // Calling from viewmodel class
        misReportesViewModel.requestGetMisReporte()
        closureSetUp()
    }
    
    // Closure initialize
    func closureSetUp()  {
        misReportesViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.tvMisReportes.reloadData()
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }

        }
        misReportesViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                
                self?.tvMisReportes.isHidden = true
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
        }
    }
}

extension MisReportesViewController: UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return misReportesViewModel.listArrayMisReportes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvMisReportes.dequeueReusableCell(withIdentifier: "MisReportesCell", for: indexPath as IndexPath) as! MisReportesTableViewCell
        
        let data = misReportesViewModel.listArrayMisReportes[indexPath.row]
        
        cell.imageIcon.makeRounded()
        cell.imageIcon.sd_setImage(with: URL(string: data.imgAlerta ?? ""), placeholderImage: UIImage(named: Constants.App.imagePlaceholder))
        cell.lblTitle.text = data.alerta ?? ""
        cell.lblBadge.setTitle(data.estado, for: .normal)
        
        if (data.estado == "Ingresado") {
            cell.lblBadge.customButton(bcColor: Constants.PaletteColors.statusBlue, borderRadius: Constants.App.cornerRadiusButton)

        } else if (data.estado == "En proceso") {
            cell.lblBadge.customButton(bcColor: Constants.PaletteColors.statusYellow, borderRadius: Constants.App.cornerRadiusButton)
            
        } else {
            cell.lblBadge.customButton(bcColor: Constants.PaletteColors.statusGreen, borderRadius: Constants.App.cornerRadiusButton)
        }
        
        
        return cell
    }
    
    
}

extension MisReportesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = misReportesViewModel.listArrayMisReportes[indexPath.row]
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "ReporteDetalleViewController") as! ReporteDetalleViewController
        vc.paramIdReporte = data.idReporte ?? 0
        navigationController?.pushViewController(vc, animated: true)
        
        print("\(data.alerta ?? "")")
    }

}

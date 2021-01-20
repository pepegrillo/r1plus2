//
//  BeneficioResidencialViewcontroller.swift
//  rplusapp
//
//  Created by Josué López on 12/2/20.
//

import UIKit

class BeneficioResidencialViewcontroller: UIViewController {
    
    @IBOutlet weak var tvBeneficio: UITableView!
    
    private var beneficioResidencialViewModel = BeneficioResidencialViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
        
    }
}

extension BeneficioResidencialViewcontroller {
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // Tableview Set DataSource and DataDelegate
        tvBeneficio.dataSource = self
        tvBeneficio.delegate = self
        
        // Call pageSetup
        pageSetup()
    }
    
    // Initial page setup
    private func pageSetup()  {
        
        // Calling from viewmodel class
        beneficioResidencialViewModel.requestGetBeneficioResidencial()
        
        closureSetUp()
    }
    
    // Closure initialize
    func closureSetUp()  {
        beneficioResidencialViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.tvBeneficio.reloadData()
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
            
        }
        beneficioResidencialViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                
                self?.tvBeneficio.isHidden = true
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
        }
    }
}

extension BeneficioResidencialViewcontroller: UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvBeneficio.dequeueReusableCell(withIdentifier: "BeneficioRestriccionCell", for: indexPath as IndexPath) as! BeneficioRestriccionTableViewCell
        
        let data = beneficioResidencialViewModel.listArray[indexPath.row]
        
        cell.container.cornerRadiusView(borderRadius: Constants.App.cornerRadiusView)
        if indexPath.row % 2 == 0 {
            cell.container.backgroundColor = Constants.PaletteColors.listBeneficioGray
            
        } else {
            cell.container.backgroundColor = Constants.PaletteColors.listBeneficioGreen
        }
        
        cell.lblName.text = data.title ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beneficioResidencialViewModel.listArray.count
        
    }
}

extension BeneficioResidencialViewcontroller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = beneficioResidencialViewModel.listArray[indexPath.row]
        
         
         let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "GeneralWebviewViewController") as! GeneralWebviewViewController
        vc.strTitle = data.title ?? ""
        vc.strURL = "https://rplus.latmobile.com/view/beneficio/\(data.id ?? 0)"
         
         navigationController?.pushViewController(vc, animated: true)
         
        print("\(data.title ?? "")")
    }

}

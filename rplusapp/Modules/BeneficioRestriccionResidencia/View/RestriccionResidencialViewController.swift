//
//  RestriccionResidencialViewController.swift
//  rplusapp
//
//  Created by Josué López on 12/2/20.
//

import UIKit

class RestriccionResidencialViewController: UIViewController {
    
    @IBOutlet weak var tvRestriccion: UITableView!
    
    private var restriccionResidencialViewModel = RestriccionResidencialViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
    }
}

extension RestriccionResidencialViewController {
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // Tableview Set DataSource and DataDelegate
        tvRestriccion.dataSource = self
        tvRestriccion.delegate = self
        
        // Call pageSetup
        pageSetup()
    }
    
    // Initial page setup
    private func pageSetup()  {
        
        // Calling from viewmodel class
        restriccionResidencialViewModel.requestGetRestriccionResidencial()
        
        closureSetUp()
    }
    
    // Closure initialize
    func closureSetUp()  {
        restriccionResidencialViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.tvRestriccion.reloadData()
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
            
        }
        restriccionResidencialViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                
                self?.tvRestriccion.isHidden = true
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
        }
    }
}

extension RestriccionResidencialViewController: UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvRestriccion.dequeueReusableCell(withIdentifier: "BeneficioRestriccionCell", for: indexPath as IndexPath) as! BeneficioRestriccionTableViewCell
        
        let data = restriccionResidencialViewModel.listArray[indexPath.row]
        
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
        return restriccionResidencialViewModel.listArray.count
        
    }
}

extension RestriccionResidencialViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = restriccionResidencialViewModel.listArray[indexPath.row]
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "GeneralWebviewViewController") as! GeneralWebviewViewController
       vc.strTitle = data.title ?? ""
       vc.strURL = "https://rplus.latmobile.com/view/reglamento/\(data.id ?? 0)"
        
        navigationController?.pushViewController(vc, animated: true)
        
        print("\(data.title ?? "")")
    }

}

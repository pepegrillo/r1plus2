//
//  ProveedorAllViewController.swift
//  rplusapp
//
//  Created by Josué López on 12/7/20.
//

import UIKit

class ProveedorAllViewController: UIViewController {
    
    @IBOutlet weak var tvProveedor: UITableView!
    
    private var proveedorViewModel = ProveedorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
    }
    
}

extension ProveedorAllViewController {
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // Tableview Set DataSource and DataDelegate
        tvProveedor.dataSource = self
        tvProveedor.delegate = self
        
        // Call pageSetup
        pageSetup()
    }
    
    // Initial page setup
    private func pageSetup()  {
        // Calling from viewmodel class
        proveedorViewModel.requestGetProveedor(paramTypeUrl: 1)
        closureSetUp()
    }
    
    // Closure initialize
    func closureSetUp()  {
        proveedorViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.tvProveedor.reloadData()
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
            
        }
        proveedorViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                
                self?.tvProveedor.isHidden = true
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
        }
    }
}

extension ProveedorAllViewController: UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvProveedor.dequeueReusableCell(withIdentifier: "GeneralModelCell", for: indexPath as IndexPath) as! GeneralModelTableViewCell
        
        let data = proveedorViewModel.listArray[indexPath.row]
        
        cell.lblTitle.text = data.name ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proveedorViewModel.listArray.count
        
    }
}

extension ProveedorAllViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = proveedorViewModel.listArray[indexPath.row]
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "PerfilGenericoViewController") as! PerfilGenericoViewController
        vc.paramTipoPerfil = "proveedor"
        vc.paramNombre = "\(data.name ?? "") \(data.lastName ?? "")"
        vc.paramLogo = data.logo
        vc.paramPhone = data.telefonos?[0].phone
        navigationController?.pushViewController(vc, animated: true)
        
        print("\(String(describing: data.lastName))")
    }
}

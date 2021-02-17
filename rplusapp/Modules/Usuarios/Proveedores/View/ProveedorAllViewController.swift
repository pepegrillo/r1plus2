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
    
    // MARK: - Delete & Edit General Actions
    private var deleteViewModel: DeleteViewModel {
        DeleteViewModel(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
    }
    
    @IBAction func actionProveedorDelete(_ sender : UIButton){
        print(sender.tag)
        let data = proveedorViewModel.listArray[sender.tag]
        
        // Create the alert controller
        let alertController = UIAlertController(title: "Eliminar", message: "¿Desea eliminar el pase de - \(data.name?.capitalized ?? "visita") ?", preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "Eliminar", style: UIAlertAction.Style.destructive) {
            UIAlertAction in
            self.deleteViewModel.requestDelete(idIdElement: data.id ?? 0, idUrl: "proveedor")
        }
        let cancelAction = UIAlertAction(title:"Cancelar", style: .cancel) { (action: UIAlertAction) in }

        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
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
        
        cell.imageAvatar.makeRounded()
        cell.imageAvatar.sd_setImage(with: URL(string: "\(data.logo ?? "")"), placeholderImage: UIImage(named: Constants.App.imagePlaceholder))
        cell.lblTitle.text = "\(data.date ?? "") - \(data.hour ?? "")"
        
        // actions CRUD
        cell.btnDelete.tag = indexPath.row
        
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
        vc.paramFecha = data.date ?? "-"
        vc.paramHora = data.hour ?? "-"
        navigationController?.pushViewController(vc, animated: true)
        
        print("\(String(describing: data.lastName))")
    }
}

extension ProveedorAllViewController: DeleteDelegate {
    func DeleteRequestCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: "Elemento eliminado exitoso", title: "Mensaje")
            self.pageSetup()
        }
    }
    
    func DeleteRequestCompleted(with error: String) {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: error, title: "Error")
            
        }
    }
}


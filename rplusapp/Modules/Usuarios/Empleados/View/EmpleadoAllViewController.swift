//
//  EmpleadoAllViewController.swift
//  rplusapp
//
//  Created by Josué López on 12/7/20.
//

import UIKit

class EmpleadoAllViewController: UIViewController {
    
    @IBOutlet weak var tvEmpleado: UITableView!
    
    private var empleadoViewModel = EmpleadoViewModel()
    
    // MARK: - Delete & Edit General Actions
    private var deleteViewModel: DeleteViewModel {
        DeleteViewModel(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
    }
    
    @IBAction func actionEmpleadoDelete(_ sender : UIButton){
        print(sender.tag)
        let data = empleadoViewModel.listArray[sender.tag]
        
        // Create the alert controller
        let alertController = UIAlertController(title: "Eliminar", message: "¿Desea eliminar el pase de - \(data.name?.capitalized ?? "visita") ?", preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "Eliminar", style: UIAlertAction.Style.destructive) {
            UIAlertAction in
            self.deleteViewModel.requestDelete(idIdElement: data.id ?? 0, idUrl: "empleado")
        }
        let cancelAction = UIAlertAction(title:"Cancelar", style: .cancel) { (action: UIAlertAction) in }

        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}

extension EmpleadoAllViewController {
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // Tableview Set DataSource and DataDelegate
        tvEmpleado.dataSource = self
        tvEmpleado.delegate = self
        
        // Call pageSetup
        pageSetup()
    }
    
    // Initial page setup
    private func pageSetup()  {
        // Calling from viewmodel class
        empleadoViewModel.requestGetEmpleado(paramTypeUrl: 1)
        closureSetUp()
    }
    
    // Closure initialize
    func closureSetUp()  {
        empleadoViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.tvEmpleado.reloadData()
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
            
        }
        empleadoViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                
                self?.tvEmpleado.isHidden = true
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
        }
    }
}

extension EmpleadoAllViewController: UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvEmpleado.dequeueReusableCell(withIdentifier: "GeneralModelCell", for: indexPath as IndexPath) as! GeneralModelTableViewCell
        
        let data = empleadoViewModel.listArray[indexPath.row]
        
        cell.lblTitle.text = data.name ?? ""
        
        // actions CRUD
        cell.btnDelete.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empleadoViewModel.listArray.count
        
    }
}

extension EmpleadoAllViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = empleadoViewModel.listArray[indexPath.row]
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "EmpleadoDetalleViewController") as! EmpleadoDetalleViewController
        vc.paramIdEmpleado = data.id ?? 0
        navigationController?.pushViewController(vc, animated: true)
        
        print("\(String(describing: data.lastName))")
    }
}

extension EmpleadoAllViewController: DeleteDelegate {
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

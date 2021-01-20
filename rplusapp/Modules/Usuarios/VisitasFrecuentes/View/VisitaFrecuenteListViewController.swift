//
//  VisitaFrecuenteListViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/20/20.
//

import UIKit

class VisitaFrecuenteListViewController: UIViewController {
    
    @IBOutlet weak var tvVisitaFrecuente: UITableView!
    
    private var visitaFrecuenteViewModel = VisitaFrecuenteViewModel()
    
    // MARK: - Delete & Edit General Actions
    private var deleteViewModel: DeleteViewModel {
        DeleteViewModel(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
    }
    
    
    @IBAction func actionVisitanteDelete(_ sender : UIButton){
        print(sender.tag)
        let data = visitaFrecuenteViewModel.listArray[sender.tag]
        
        // Create the alert controller
        let alertController = UIAlertController(title: "Eliminar", message: "¿Desea eliminar el pase de - \(data.name?.capitalized ?? "visita") ?", preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "Eliminar", style: UIAlertAction.Style.destructive) {
            UIAlertAction in
            self.deleteViewModel.requestDelete(idIdElement: data.id ?? 0, idUrl: "eliminar_visita")
        }
        let cancelAction = UIAlertAction(title:"Cancelar", style: .cancel) { (action: UIAlertAction) in }

        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }

}

extension VisitaFrecuenteListViewController {
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // Tableview Set DataSource and DataDelegate
        tvVisitaFrecuente.dataSource = self
        tvVisitaFrecuente.delegate = self
        
        // Call pageSetup
        pageSetup()
    }
    
    // Initial page setup
    private func pageSetup()  {
        // Calling from viewmodel class
        visitaFrecuenteViewModel.requestGetVisitaFrecuente(paramTypeUrl: 1)
        closureSetUp()
    }
    
    // Closure initialize
    func closureSetUp()  {
        visitaFrecuenteViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.tvVisitaFrecuente.reloadData()
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }

        }
        visitaFrecuenteViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                
                self?.tvVisitaFrecuente.isHidden = true
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
        }
    }
}

extension VisitaFrecuenteListViewController: UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visitaFrecuenteViewModel.listArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvVisitaFrecuente.dequeueReusableCell(withIdentifier: "VisitaFrecuenteCell", for: indexPath as IndexPath) as! VisitaFrecuenteTableViewCell
        
        let data = visitaFrecuenteViewModel.listArray[indexPath.row]
        
        
        cell.lblNombre.text = "\(data.name?.capitalized ?? "") \(data.lastName?.capitalized ?? "")"
        
        // actions CRUD
        cell.btnDelete.tag = indexPath.row
        
        return cell
    }
    
    
}

extension VisitaFrecuenteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = visitaFrecuenteViewModel.listArray[indexPath.row]
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "PerfilGenericoViewController") as! PerfilGenericoViewController
        vc.paramNombre = "\(data.name ?? "") \(data.lastName ?? "")"
        navigationController?.pushViewController(vc, animated: true)
        
        print("\(data.name ?? "")")
    }

}

extension VisitaFrecuenteListViewController: DeleteDelegate {
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

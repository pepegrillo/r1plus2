//
//  TipoResidenteViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/25/20.
//

import UIKit

class TipoResidenteViewController: UIViewController {
    
    @IBOutlet weak var tvTipoResidente: UITableView!
    
    var paramIdResidencia = 0
    
    private var tipoResidenteViewModel = TipoResidenteViewModel()
    
    private var setTipoResidenteViewModel: SetTipoResidenteViewModel {
        SetTipoResidenteViewModel(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
    }
    
}

extension TipoResidenteViewController {
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // Tableview Set DataSource and DataDelegate
        tvTipoResidente.dataSource = self
        tvTipoResidente.delegate = self
        
        // Call pageSetup
        pageSetup()
    }
    
    // Initial page setup
    private func pageSetup()  {
        // Calling from viewmodel class
        tipoResidenteViewModel.requestGetTipoResidente(paramIdResidencial: "1")
        closureSetUp()
    }
    
    // Closure initialize
    func closureSetUp()  {
        tipoResidenteViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.tvTipoResidente.reloadData()
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
            
        }
        tipoResidenteViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                
                self?.tvTipoResidente.isHidden = true
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
        }
    }
}

extension TipoResidenteViewController: UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvTipoResidente.dequeueReusableCell(withIdentifier: "DirectorioCell", for: indexPath as IndexPath) as! DirectorioTableViewCell
        
        let data = tipoResidenteViewModel.listArray[indexPath.row]
        
        cell.lblName.text = data.name ?? ""
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tipoResidenteViewModel.listArray.count
        
    }
}

extension TipoResidenteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = tipoResidenteViewModel.listArray[indexPath.row]
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        setTipoResidenteViewModel.requestSetTipoResidente(body: ["\(paramIdResidencia)","\(data.id ?? 0)"])
        
        print("\(data.name ?? "")")
    }
    
}

extension TipoResidenteViewController: SetTipoResidenteDelegate{
    func setTipoResidenteCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            //self.dismiss(animated: true, completion: nil)
            self.presentingViewController?
                    .presentingViewController?.dismiss(animated: true, completion: nil)
            sleep(1)
            AlertManager.showAlert(withMessage: "Residencial registrada", title: "Mensaje")
            
        }
    }
    
    func setTipoResidenteCompleted(with error: String) {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            //self.dismiss(animated: true, completion: nil)
            self.presentingViewController?
                    .presentingViewController?.dismiss(animated: true, completion: nil)
            sleep(1)
            AlertManager.showAlert(withMessage: error, title: "Error")
        }
    }
    
    
}

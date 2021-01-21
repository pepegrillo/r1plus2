//
//  UsuariosViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/10/20.
//

import UIKit

class UsuariosViewController: UIViewController {
    
    // MARK: - Visitas Frecuentes Parameters
    @IBOutlet weak var btnVerTodoVisitaFrecuente: UIButton!
    @IBOutlet weak var cvVisitaFrecuente: UICollectionView!
    @IBOutlet weak var containerEmptyVisita: UIView!
    
    private var visitaFrecuenteViewModel = VisitaFrecuenteViewModel()
    
    
    // MARK: - Proveedores Parameters
    @IBOutlet weak var btnVerTodoProveedor: UIButton!
    @IBOutlet weak var cvProveedor: UICollectionView!
    @IBOutlet weak var containerEmptyProveedor: UIView!
    
    private var proveedorViewModel = ProveedorViewModel()
    
    
    // MARK: - Empleados Parameters
    @IBOutlet weak var btnVerTodoEmpleado: UIButton!
    @IBOutlet weak var cvEmpleado: UICollectionView!
    @IBOutlet weak var containerEmptyEmpleado: UIView!
    
    private var empleadoViewModel = EmpleadoViewModel()
    
    
    // MARK: - Delete & Edit General Actions
    // typeDelete indetify kind of visita
    private var typeDelete: Int = 0
    private var deleteViewModel: DeleteViewModel {
        DeleteViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.visibleViewController?.title = "Usuarios"
        
        // init loading
        initialMethod()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set design
        setDesign()
        
        // testing Realm
        //AppData.sharedData.updateContactosObject()
    }
    
    // MARK: - Visitas Frecuentes Parameters
    @IBAction func actionAnunciarVisitante(_ sender: Any) {
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "ContactosViewController") as! ContactosViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionVisitantesAll(_ sender: UIButton) {
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "VisitaFrecuenteListViewController") as! VisitaFrecuenteListViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionVisitanteDelete(_ sender : UIButton){
        print(sender.tag)
        let data = visitaFrecuenteViewModel.listArray[sender.tag]
        
        // Create the alert controller
        let alertController = UIAlertController(title: "Eliminar", message: "¿Desea eliminar el pase de - \(data.name?.capitalized ?? "visita") ?", preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "Eliminar", style: UIAlertAction.Style.destructive) {
            UIAlertAction in
            NSLog("OK Pressed")
            self.typeDelete = 1
            self.deleteViewModel.requestDelete(idIdElement: data.id ?? 0, idUrl: "eliminar_visita")
        }
        let cancelAction = UIAlertAction(title:"Cancelar", style: .cancel) { (action: UIAlertAction) in }

        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - Proveedor Parameters
    @IBAction func actionProveedorAll(_ sender: UIButton) {
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "ProveedorAllViewController") as! ProveedorAllViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionProveedorDelete(_ sender : UIButton){
        print(sender.tag)
        let data = proveedorViewModel.listArray[sender.tag]
        
        // Create the alert controller
        let alertController = UIAlertController(title: "Eliminar", message: "¿Desea eliminar el pase de - \(data.name?.capitalized ?? "proveedor") ?", preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "Eliminar", style: UIAlertAction.Style.destructive) {
            UIAlertAction in
            NSLog("OK Pressed")
            self.typeDelete = 2
            self.deleteViewModel.requestDelete(idIdElement: data.id ?? 0, idUrl: "empleado")
        }
        let cancelAction = UIAlertAction(title:"Cancelar", style: .cancel) { (action: UIAlertAction) in }

        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - Empleador Parameters
    @IBAction func actionEmpleadoAll(_ sender: UIButton) {
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "EmpleadoAllViewController") as! EmpleadoAllViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionEmpleadoDelete(_ sender : UIButton){
        print(sender.tag)
        let data = empleadoViewModel.listArray[sender.tag]
        
        // Create the alert controller
        let alertController = UIAlertController(title: "Eliminar", message: "¿Desea eliminar el pase de - \(data.name?.capitalized ?? "empleado") ?", preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "Eliminar", style: UIAlertAction.Style.destructive) {
            UIAlertAction in
            NSLog("OK Pressed")
            self.typeDelete = 3
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

extension UsuariosViewController {
    
    private func setDesign() {
        
        self.btnVerTodoVisitaFrecuente.customButton(bcColor: .white, borderRadius: Constants.App.cornerRadiusButton)
        self.btnVerTodoProveedor.customButton(bcColor: .white, borderRadius: Constants.App.cornerRadiusButton)
        self.btnVerTodoEmpleado.customButton(bcColor: .white, borderRadius: Constants.App.cornerRadiusButton)
        
    }
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // Tableview Set DataSource and DataDelegate
        cvVisitaFrecuente.dataSource = self
        cvVisitaFrecuente.delegate = self
        
        cvProveedor.dataSource = self
        cvProveedor.delegate = self
        
        cvEmpleado.dataSource = self
        cvEmpleado.delegate = self
        
        // Call pageSetup
        pageSetup()
    }
    
    // Initial page setup
    private func pageSetup(paramReload: Int? = 0 )  {
        // Calling from viewmodel class
        
        if paramReload == 1 { //visita frecuente
            visitaFrecuenteViewModel.requestGetVisitaFrecuente()
        } else if paramReload == 2 { // proveedor
            proveedorViewModel.requestGetProveedor()
        } else if paramReload == 3 { // empleado
            empleadoViewModel.requestGetEmpleado()
        } else {
            visitaFrecuenteViewModel.requestGetVisitaFrecuente()
            proveedorViewModel.requestGetProveedor()
            empleadoViewModel.requestGetEmpleado()
        }
    
        closureSetUp()
    }
    
    // Closure initialize
    func closureSetUp()  {
        visitaFrecuenteViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                
                    self?.cvVisitaFrecuente.reloadData()
                    ActivityIndicator.sharedIndicator.hideActivityIndicator()
                    
            }
            
        }
        visitaFrecuenteViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                
                self?.cvVisitaFrecuente.isHidden = true
                self?.containerEmptyVisita.isHidden = false
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
        }
        
        // proveedor
        proveedorViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                
                    self?.cvProveedor.reloadData()
                    
            }
            
        }
        proveedorViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                
                self?.cvProveedor.isHidden = true
                self?.containerEmptyProveedor.isHidden = false
                
            }
        }
        
        // empleado
        empleadoViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                
                    self?.cvEmpleado.reloadData()
                    
            }
            
        }
        empleadoViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                
                self?.cvEmpleado.isHidden = true
                self?.containerEmptyEmpleado.isHidden = false
                
            }
        }
    }
}

extension UsuariosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView == self.cvVisitaFrecuente) {
            print("cvVisitaFrecuente")
            
            let data = visitaFrecuenteViewModel.listArray[indexPath.row]
            let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "PerfilGenericoViewController") as! PerfilGenericoViewController
            vc.paramNombre = "\(data.name ?? "") \(data.lastName ?? "")"
            navigationController?.pushViewController(vc, animated: true)
            
        } else if (collectionView == self.cvProveedor) {
            print("cProveedor")
            
            let data = proveedorViewModel.listArray[indexPath.row]
            let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "PerfilGenericoViewController") as! PerfilGenericoViewController
            vc.paramTipoPerfil = "proveedor"
            vc.paramNombre = "\(data.name ?? "") \(data.lastName ?? "")"
            vc.paramLogo = data.logo
            vc.paramPhone = data.telefonos?[0].phone
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            print("cvEmpleado")
            let data = empleadoViewModel.listArray[indexPath.row]
            
            let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "EmpleadoDetalleViewController") as! EmpleadoDetalleViewController
            vc.paramIdEmpleado = data.id ?? 0
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

extension UsuariosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == self.cvVisitaFrecuente) {
            return visitaFrecuenteViewModel.listArray.count
        } else if (collectionView == self.cvProveedor) {
            return proveedorViewModel.listArray.count
        } else {
            return empleadoViewModel.listArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.cvVisitaFrecuente) {
            
            let cell = cvVisitaFrecuente.dequeueReusableCell(withReuseIdentifier: "VisitaFrecuenteCell", for: indexPath as IndexPath) as! VisitaFrecuenteCollectionViewCell
            
            let data = visitaFrecuenteViewModel.listArray[indexPath.row]
            
            cell.container.cornerRadiusView(borderRadius: Constants.App.cornerRadiusView)
            
            cell.lblNombre?.text = data.name?.capitalized
            cell.lblApellido?.text = data.lastName?.capitalized
            cell.lblTelefono?.text = "00"
            
            // actions CRUD
            cell.btnDelete.tag = indexPath.row
            
            return cell
            
        } else if (collectionView == self.cvProveedor) {
            
            let cell = cvProveedor.dequeueReusableCell(withReuseIdentifier: "ProveedorCell", for: indexPath as IndexPath) as! ProveedorCollectionViewCell
            
            let data = proveedorViewModel.listArray[indexPath.row]
            
            cell.container.cornerRadiusView(borderRadius: Constants.App.cornerRadiusView)
            
            cell.imageAvatar.sd_setImage(with: URL(string: "\(data.logo ?? "")"), placeholderImage: UIImage(named: Constants.App.imagePlaceholder))
            cell.lblNombre?.text = data.name?.capitalized
            cell.lblEmpresa?.text = data.lastName?.capitalized
            
            return cell
        
        } else {
            
            let cell = cvEmpleado.dequeueReusableCell(withReuseIdentifier: "EmpleadoCell", for: indexPath as IndexPath) as! EmpleadoCollectionViewCell
            
            let data = empleadoViewModel.listArray[indexPath.row]
            
            cell.container.cornerRadiusView(borderRadius: Constants.App.cornerRadiusView)
            
            cell.imageAvatar.sd_setImage(with: URL(string: "\(data.imgDuiFrente ?? "")"), placeholderImage: UIImage(named: Constants.App.imagePlaceholder))
            cell.lblNombre?.text = data.name?.capitalized
            cell.lblFecha?.text = data.lastName?.capitalized
            cell.lblHora?.text = data.telefonos?[0].phone
            
            // actions CRUD
            cell.btnDelete.tag = indexPath.row
            
            return cell
        }
        
        
    }
}

// MARK: - Delete & Edit General Actions
extension UsuariosViewController: DeleteDelegate{
    func DeleteRequestCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: "Elemento eliminado exitoso", title: "Mensaje")
            if (self.typeDelete == 1) {
                self.pageSetup(paramReload: 1)
            } else if (self.typeDelete == 2) {
                self.pageSetup(paramReload: 2)
            } else {
                self.pageSetup(paramReload: 3)
            }
            
        }
    }
    
    func DeleteRequestCompleted(with error: String) {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: error, title: "Error")
            
        }
    }
    
    
}

//
//  DirectorioViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/10/20.
//

import UIKit

class DirectorioViewController: UIViewController {
    
    @IBOutlet weak var tvDirectorio: UITableView!
    
    private var directorioViewModel = DirectorioViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.visibleViewController?.title = "Directorio"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
    }
    
}

extension DirectorioViewController {
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // Tableview Set DataSource and DataDelegate
        tvDirectorio.dataSource = self
        tvDirectorio.delegate = self
        
        // Call pageSetup
        pageSetup()
    }
    
    // Initial page setup
    private func pageSetup()  {
        // Calling from viewmodel class
        directorioViewModel.requestGetDirectorio()
        closureSetUp()
    }
    
    // Closure initialize
    func closureSetUp()  {
        directorioViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.tvDirectorio.reloadData()
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
            
        }
        directorioViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                
                self?.tvDirectorio.isHidden = true
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
        }
    }
}

extension DirectorioViewController: UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvDirectorio.dequeueReusableCell(withIdentifier: "DirectorioCell", for: indexPath as IndexPath) as! DirectorioTableViewCell
        
        let data = directorioViewModel.listArrayAdministracion[indexPath.row]
        
        cell.imageIcon.sd_setImage(with: URL(string: "\(data.photo ?? "")"))
        cell.lblName.text = data.name ?? ""
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directorioViewModel.listArrayAdministracion.count
        
    }
}

extension DirectorioViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = directorioViewModel.listArrayAdministracion[indexPath.row]
        
        if let url = URL(string: "tel://\(data.phone ?? "")") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
}

//
//  MascotasViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/19/20.
//

import UIKit

class MascotasViewController: UIViewController {
    
    @IBOutlet weak var tvMascotas: UITableView!
    
    private var mascotasViewModel = MascotaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
    }
    
    @IBAction func actionAgregarMascota(_ sender: Any) {
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "RegistroMascotaViewController") as!
            RegistroMascotaViewController
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension MascotasViewController {
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // Tableview Set DataSource and DataDelegate
        tvMascotas.dataSource = self
        tvMascotas.delegate = self
        
        // Call pageSetup
        pageSetup()
    }
    
    // Initial page setup
    private func pageSetup()  {
        // Calling from viewmodel class
        mascotasViewModel.requestGetMascota()
        closureSetUp()
    }
    
    // Closure initialize
    func closureSetUp()  {
        mascotasViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.tvMascotas.reloadData()
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }

        }
        mascotasViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                
                self?.tvMascotas.isHidden = true
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
        }
    }
}

extension MascotasViewController: UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mascotasViewModel.listArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvMascotas.dequeueReusableCell(withIdentifier: "MascotasCell", for: indexPath as IndexPath) as! MascotasTableViewCell
        
        let data = mascotasViewModel.listArray[indexPath.row]
        
        
        cell.lblName.text = data.name ?? ""
        
        
        
        return cell
    }
    
    
}

extension MascotasViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = mascotasViewModel.listArray[indexPath.row]
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "PerfilMascotaViewController") as! PerfilMascotaViewController
        vc.paramIdMascota = data.id ?? 0
        navigationController?.pushViewController(vc, animated: true)
        
        print("\(data.name ?? "")")
    }

}

//
//  OpcionesViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/10/20.
//

import UIKit

class OpcionesViewController: UIViewController {
    
    @IBOutlet weak var tvOpciones: UITableView!
    
    var opcionViewModel = OpcionViewModel()
    var rows: [Opcion] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.visibleViewController?.title = "Opciones"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
    }
    
    //MARK: Menu Actions
    func actionMiPerfil() {
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "MiPerfilViewController") as! MiPerfilViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func actionAgregarCasa() {
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "AgregarCasaViewController") as! AgregarCasaViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func actionDirectorio() {
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "DirectorioViewController") as! DirectorioViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func actionHistorialPago() {
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "HistorialPagoViewController") as! HistorialPagoViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func actionMascotas() {
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "MascotasViewController") as! MascotasViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func actionBeneficios() {
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "BeneficioResidencialViewcontroller") as! BeneficioResidencialViewcontroller
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func actionRestricciones() {
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "RestriccionResidencialViewController") as! RestriccionResidencialViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func actionLogout() {
        // call alert
        TokenManager.invalidSession(onVC: self)
//        sleep(1)
//        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
}

extension OpcionesViewController {
    
    private func initialMethod() {
        
        self.rows = opcionViewModel.allLayers()
        
        // Tableview Set DataSource and DataDelegate
        tvOpciones.dataSource = self
        tvOpciones.delegate = self
    }
    
}

extension OpcionesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row: Opcion = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath) as! OpcionesTableViewCell
        cell.lblTitle.text = row.name
        cell.icon.image = UIImage(named: row.iconName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = rows[indexPath.row]
        
        switch row {
            case .miPerfil:
                actionMiPerfil()
            case .agregarResidencial:
                actionMiPerfil()
            case .agregarCasa:
                actionAgregarCasa()
            case .directorio:
                actionDirectorio()
            case .historialPases:
                actionMiPerfil()
            case .historialPagos:
                actionHistorialPago()
            case .usuariosAdicionales:
                actionMiPerfil()
            case .mascotas:
                actionMascotas()
            case .beneficiosResidencia:
                actionBeneficios()
            case .restriccionesResidencia:
                actionRestricciones()
            case .cerrarSesion:
                actionLogout()
        }
    }
    
}

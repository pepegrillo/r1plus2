//
//  HomeViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/10/20.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    // MARK: - Perfil Outlets
    @IBOutlet weak var containerPerfil: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblCondominio: UILabel!
    @IBOutlet weak var lblTipoResidente: UILabel!
    @IBOutlet weak var btnAgregarResidencial: UIButton!
    
    private var perfilViewModel: PerfilViewModel{
        PerfilViewModel(delegate: self)
    }
    
    // MARK: - Pases Asignados Parameters
    @IBOutlet weak var btnVerTodoPases: UIButton!
    @IBOutlet weak var cvPasesAsignados: UICollectionView!
    @IBOutlet weak var containerEmptyPases: UIView!
    
    private var pasesAsignadosViewModel = PasesAsignadosViewModel()
    
    // MARK: - Anuncio Parameters
    @IBOutlet weak var btnVerTodoAnuncios: UIButton!
    @IBOutlet weak var cvAnuncio: UICollectionView!
    @IBOutlet weak var containerEmptyAnuncio: UIView!
    
    private var anuncioViewModel = AnuncioViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.visibleViewController?.title = "Bienvenido"
        
        // init loading
        initialMethod()
        
        // delete Realm contacts for testing
        AppData.sharedData.removeContactosObject()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set design
        setDesign()
        
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "REALMS")
    }
    
    
    @IBAction func actionAgregarResidencial(_ sender: Any) {
        
//        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "ResidencialViewController") as! ResidencialViewController
//        navigationController?.pushViewController(vc, animated: true)
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "ResidencialViewController") as! ResidencialViewController
        self.present(vc, animated: true)

    }
}

// MARK: - Perfil Parameters
extension HomeViewController: PerfilViewModelDelegate {
    func perfilViewModelRequestCompleted() {
        print("perfil exitoso")
        
        DispatchQueue.main.async {
            
            let dataPerfil = GlobalParameters.instance().globalDataPerfil
            
            self.imgAvatar.sd_setImage(with: URL(string: dataPerfil[0].avatar ?? ""), placeholderImage: UIImage(named: Constants.App.imagePlaceholder))
            self.lblNombre.text = dataPerfil[0].nombre?.capitalized
            self.lblTipoResidente.text = dataPerfil[0].tipoResidente
            
            if dataPerfil[0].tieneResidencial == 1{
                self.btnAgregarResidencial.isHidden = true
            }
        }
    }
    
    func perfilViewModelRequestCompleted(with error: String) {
        print("perfil con error")
    }
    
    
}

extension HomeViewController {
    
    private func setDesign() {
        
//        self.navigationController?.visibleViewController?.title = "Bienvenido"
        
        self.imgAvatar.makeRounded()
        
        self.btnVerTodoPases.customButton(bcColor: .white, borderRadius: Constants.App.cornerRadiusButton)
        self.btnVerTodoAnuncios.customButton(bcColor: .white, borderRadius: Constants.App.cornerRadiusButton)
        
    }
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // MARK: perfil parameters
        perfilViewModel.requestGetPerfil()
        
        // Tableview Set DataSource and DataDelegate
        cvPasesAsignados.dataSource = self
        cvPasesAsignados.delegate = self
        
        cvAnuncio.dataSource = self
        cvAnuncio.delegate = self
        
        // Call pageSetup
        pageSetup()
    }
    
    // Initial page setup
    private func pageSetup()  {
        // Calling from viewmodel class
        
        // MARK: pases asignados parameters
        pasesAsignadosViewModel.requestGetPasesAsignados()
        
        // MARK: anuncio parameters
        anuncioViewModel.requestGetAnuncio()
        
        closureSetUp()
    }
    
    // Closure initialize
    func closureSetUp()  {
        
        // MARK: pases asignados parameters
        pasesAsignadosViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
//                let data = pasesAsignadosViewModel.listArray[0]
//                guard let data = self?.pasesAsignadosViewModel.listArray[0].code, data.id == 32 else {
                    self?.cvPasesAsignados.reloadData()
//                    return
//                }
//                self?.cvPasesAsignados.isHidden = true
//                self?.containerEmptyPases.isHidden = false
            }
            
        }
        pasesAsignadosViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                self?.cvPasesAsignados.isHidden = true
                self?.containerEmptyPases.isHidden = false
            }
        }
        
        // MARK: anuncio parameters
        anuncioViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.cvAnuncio.reloadData()
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
            
        }
        anuncioViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                
                self?.cvAnuncio.isHidden = true
                self?.containerEmptyAnuncio.isHidden = false
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView == self.cvPasesAsignados) {
            
            let data = pasesAsignadosViewModel.listArray[indexPath.row]
            
            let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "PaseAsignadoDetalleViewController") as! PaseAsignadoDetalleViewController
            vc.paramCondominio = data.code?.uppercased()
            vc.paramNombre = "\(data.name?.capitalized ?? "") \(data.lastName?.capitalized ?? "")"
            vc.paramTipoUsuario = data.tipo?.name ?? ""
            vc.paramCasa = data.lugar?.name ?? "NA"
            vc.paramFecha = data.date
            vc.paramHora = data.hour
            vc.paramCode = data.code
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            
            let data = anuncioViewModel.listArray[indexPath.row]
            
            let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "AnuncioDetalleViewController") as! AnuncioDetalleViewController
            vc.paramImage = data.image ?? ""
            vc.paramVigencia = data.expirationDate ?? ""
            vc.paramTitulo = data.title ?? ""
            vc.paramDescripcion = data.description ?? ""
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.cvPasesAsignados) {
            return pasesAsignadosViewModel.listArray.count
        
        } else {
            
            return anuncioViewModel.listArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.cvPasesAsignados) {
            
            let cell = cvPasesAsignados.dequeueReusableCell(withReuseIdentifier: "PasesAsignadosCell", for: indexPath as IndexPath) as! PasesAsignadosCollectionViewCell
            
            let data = pasesAsignadosViewModel.listArray[indexPath.row]
            
//            cell.container.cornerRadiusViewBorder(bcColor: .white, borderRadius: Constants.App.cornerRadiusView)
            

//            cell.lblNombre?.text = data.name?.capitalized
//            cell.lblResidencia?.text = data.code?.uppercased()
            let imageQR = GeneratorQR.createGeneratorQR.generateQRCode(from: "\(data.code ?? "")")
            cell.imageQr.image = imageQR
            cell.lblFecha?.text = data.date
            cell.lblHora?.text = data.hour
            
            return cell
        
        } else {
            
            
            let cell = cvAnuncio.dequeueReusableCell(withReuseIdentifier: "AnuncioCell", for: indexPath as IndexPath) as! AnuncioCollectionViewCell
            
            let data = anuncioViewModel.listArray[indexPath.row]
            
            cell.container.cornerRadiusViewBorder(bcColor: .white, borderRadius: Constants.App.cornerRadiusView)
            cell.containerTitle.cornerRadiusView(borderRadius: Constants.App.cornerRadiusButtonLarge)
            
            cell.imageBackground.sd_setImage(with: URL(string: "\(data.image ?? "")"), placeholderImage: UIImage(named: Constants.App.imagePlaceholder))
            cell.lblTitle?.text = data.title
            
            return cell
        }
        
    }
}

//
//  AgregarCasaViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/19/20.
//

import UIKit

class AgregarCasaViewController: UIViewController {
    
    @IBOutlet weak var containerForm1: UIView!
    
    @IBOutlet weak var txtSector: UITextField!
    @IBOutlet weak var txtUbicacion: UITextField!
    @IBOutlet weak var txtVivienda: UITextField!
    
    @IBOutlet weak var btnRegisterCasa: UIButton!
    
    // MARK: sector
    var pickerSector = UIPickerView()
    lazy var sectorData = [DataSector]()
    
    var idSectorSelected: Int?
    
    private var sectorViewModel: SectorViewModel {
        SectorViewModel(delegate: self)
    }
    
    // MARK: ubicacion por sector
    var pickerUbicacion = UIPickerView()
    lazy var ubicacionData = [DataUbicacion]()
    
    var idUbicacionSelected: Int?
    
    private var ubicacionViewModel: UbicacionViewModel {
        UbicacionViewModel(delegate: self)
    }
    
    // MARK: vivienda por ubicacion
    var pickerVivienda = UIPickerView()
    lazy var viviendaData = [DataVivienda]()
    
    var idViviendaSelected: Int?
    
    private var viviendaViewModel: ViviendaViewModel {
        ViviendaViewModel(delegate: self)
    }
    
    // MARK: registro agregar casa
    private var agregarCasaViewModel: AgregarCasaViewModel {
        AgregarCasaViewModel(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set data
        sectorViewModel.requestSector()
        
        //set design
        setScreenDesign()
    }
    
    @IBAction func actionAgregarCasa(_ sender: Any) {
        
        // send data
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: self.view)
        agregarCasaViewModel.requestAgregarCasa(body: ["\(idSectorSelected ?? 0)","\(idViviendaSelected ?? 0)"])
    }
}

extension AgregarCasaViewController {
    
    //set design
    private func setScreenDesign() {
        
        containerForm1.cornerRadiusViewBorder(bcColor: .white, borderRadius: Constants.App.cornerRadius)
//        self.txtUbicacion.isEnabled = false
//        self.txtVivienda.isEnabled = false
        
        createPickerSector()
        
        
        self.txtSector.aDefaultTxt()
        self.txtUbicacion.aDefaultTxt()
        self.txtVivienda.aDefaultTxt()
        
        
        self.btnRegisterCasa.cornerButton(borderRadius: Constants.App.cornerRadiusButton)
    }
    
    //create picker
    private func createPickerSector() {
        
        // MARK: sector
        pickerSector.delegate = self
        pickerSector.dataSource = self
        self.txtSector.inputView = pickerSector
        
        // MARK: ubicacion por sector
        pickerUbicacion.delegate = self
        pickerUbicacion.dataSource = self
        self.txtUbicacion.inputView = pickerUbicacion
        
        // MARK: ubicacion por sector
        pickerVivienda.delegate = self
        pickerVivienda.dataSource = self
        self.txtVivienda.inputView = pickerVivienda
        
    }
    
}

extension AgregarCasaViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
            case pickerSector:
                return sectorData.count
            case pickerUbicacion:
                return ubicacionData.count
            default:
                return viviendaData.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
            case pickerSector:
                return sectorData[row].name
            case pickerUbicacion:
                return ubicacionData[row].name
            default:
                return viviendaData[row].vivienda
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView {
            case pickerSector:
                txtSector.text = sectorData[row].name
                idSectorSelected = sectorData[row].id
                view.endEditing(true)
//                self.txtUbicacion.isEnabled = true
                //set data
                ubicacionViewModel.requestUbicacion(paramIdSector: idSectorSelected ?? 0)
                
            case pickerUbicacion:
                txtUbicacion.text = ubicacionData[row].name
                idUbicacionSelected = ubicacionData[row].id
                view.endEditing(true)
//                self.txtVivienda.isEnabled = true
                //set data
                viviendaViewModel.requestVivienda(paramIdUbicacion: idUbicacionSelected ?? 0)
                
            default:
                txtVivienda.text = viviendaData[row].vivienda
                idViviendaSelected = viviendaData[row].id
                view.endEditing(true)
        }
        
    }
    
    // MARK: TextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        //        navigationController?.navigationBar.isHidden = false
        return false
    }
    
}

extension AgregarCasaViewController: SectorDelegate {
    func sectorCompleted() {
        print("Sector completed")
        DispatchQueue.main.async {
            self.sectorData = GlobalParameters.instance().globalDataSector
            self.txtSector.text = self.sectorData.first?.name
            
            // MARK: ubicacion por sector
            //set data
            self.ubicacionViewModel.requestUbicacion(paramIdSector: self.sectorData.first?.id ?? 0)
            
        }
    }
    
    func sectorCompleted(with error: String) {
        print("\(error)")
    }
}

extension AgregarCasaViewController: UbicacionDelegate {
    func ubicacionCompleted() {
        print("Ubicacion completed")
        DispatchQueue.main.async {
            self.ubicacionData = GlobalParameters.instance().globalDataUbicacionPorSector
            
            guard !self.ubicacionData.isEmpty else {
                print("adentro de guard sector")
                self.txtUbicacion.isEnabled = false
                self.txtUbicacion.text = ""
                
                self.txtVivienda.isEnabled = false
                self.txtVivienda.text = ""
                return
            }
            print("afuera de guard sector")
            self.txtUbicacion.isEnabled = true
            self.txtVivienda.isEnabled = true
            
            self.txtUbicacion.text = self.ubicacionData.first?.name
            
            // MARK: vivienda por ubicacion
            //set data
            self.viviendaViewModel.requestVivienda(paramIdUbicacion: self.ubicacionData.first?.id ?? 0)
            
        }
    }
    
    func ubicacionCompleted(with error: String) {
        print("\(error)")
    }
}

extension AgregarCasaViewController: ViviendaDelegate {
    func viviendaCompleted() {
        print("Vivienda completed")
        DispatchQueue.main.async {
            self.viviendaData = GlobalParameters.instance().globalDataViviendaPorUbicacion
            
            guard !self.viviendaData.isEmpty else {
                print("adentro de guard vivienda")
                self.txtVivienda.isEnabled = false
                self.txtVivienda.text = ""
                return
            }
            print("afuera de guard vivienda")
            
            self.txtVivienda.text = self.viviendaData.first?.vivienda
            
        }
    }
    
    func viviendaCompleted(with error: String) {
        print("\(error)")
    }
    
}

extension AgregarCasaViewController: AgregarCasaDelegate {
    func agregarCasaCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: "Vivienda Ingresa exitosamente.", title: "Mensaje")
        }
    }
    
    func agregarCasaCompleted(with error: String) {
        ActivityIndicator.sharedIndicator.hideActivityIndicator()
        AlertManager.showAlert(withMessage: error, title: "Error")
    }
    
}

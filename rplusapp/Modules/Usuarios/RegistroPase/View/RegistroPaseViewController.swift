//
//  RegistroPaseViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/26/20.
//

import UIKit

class RegistroPaseViewController: UIViewController {
    
    
    @IBOutlet weak var containerGeneralForm: UIView!
    
    @IBOutlet weak var constraintContainerNombre: NSLayoutConstraint!
    @IBOutlet weak var constraintContainerApellido: NSLayoutConstraint!
    @IBOutlet weak var constraintContainerEmpleado: NSLayoutConstraint!
    @IBOutlet weak var constraintContainerProveedor: NSLayoutConstraint!
    @IBOutlet weak var constraintContainerProveedorTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var constraintContainerVisita: NSLayoutConstraint!
    @IBOutlet weak var constraintContainerVisitaTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var constraintContainerDocumentoImagen: NSLayoutConstraint!
    @IBOutlet weak var constraintContainerDate: NSLayoutConstraint!
    
    @IBOutlet weak var containerTipoVisita: UIView!
    @IBOutlet weak var containerNombre: UIView!
    @IBOutlet weak var containerApellido: UIView!
    @IBOutlet weak var containerEmpleado: UIView!
    @IBOutlet weak var containerProveedor: UIView!
    @IBOutlet weak var containerVisita: UIView!
    @IBOutlet weak var containerDocumentoImagen: UIView!
    @IBOutlet weak var containerDate: UIView!
    
    @IBOutlet weak var txtTipoRegistroPase: UITextField!
    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    
    @IBOutlet weak var txtTelefonoEmpleado: UITextField!
    @IBOutlet weak var txtDuiEmpleado: UITextField!
    
    @IBOutlet weak var txtLugarProveedor: UITextField!
    @IBOutlet weak var constraintContainerAreaProveedor: NSLayoutConstraint!
    @IBOutlet weak var containerAreaProveedor: UIView!
    @IBOutlet weak var txtAreaProveedor: UITextField!
    @IBOutlet weak var txtEmpresaProveedor: UITextField!
    @IBOutlet weak var txtEmailProveedor: UITextField!
    @IBOutlet weak var txtTelefonoProveedor: UITextField!
    
    @IBOutlet weak var txtCorreoVisita: UITextField!
    @IBOutlet weak var txtTelefonoVisita: UITextField!
    @IBOutlet weak var txtLugarVisita: UITextField!
    @IBOutlet weak var constraintContainerAreaVisita: NSLayoutConstraint!
    @IBOutlet weak var containerAreaVisita: UIView!
    @IBOutlet weak var txtAreaVisita: UITextField!
    @IBOutlet weak var txtTipoDocumentoVisita: UITextField!
    @IBOutlet weak var txtNumeroDuiVisita: UITextField!
    @IBOutlet weak var txtNumeroPlacaVisita: UITextField!
    
    @IBOutlet weak var imageDuiFrontal: UIImageView!
    @IBOutlet weak var imageDuiReverso: UIImageView!
    
    @IBOutlet weak var txtFecha: UITextField!
    @IBOutlet weak var txtHora: UITextField!
    
    @IBOutlet weak var btnRegistroPase: UIButton!
    
    
    
    // MARK: tipo de registro de pase
    var pickerTipoRegistroPase = UIPickerView()
    var rowTipoRegistroPase: [TipoRegistroPaseLayer] = []
    var pickerTipoRegistroPaseSelected = ""
    
    // MARK: Registro empleado
    private var registroPaseEmpleadoViewModel: RegistroPaseEmpleadoViewModel {
        RegistroPaseEmpleadoViewModel(delegate: self)
    }
    
    var imagePicker: ImagePicker!
    var imageDataDui1: String = ""
    var imageDataDui2: String = ""
    var tagSelected = 0
    
    // MARK: Registro proveedor
    private var registroPaseProveedorViewModel: RegistroPaseProveedorViewModel {
        RegistroPaseProveedorViewModel(delegate: self)
    }
    
    private var tipoAreaComunViewModel: TipoAreaComunViewModel {
        TipoAreaComunViewModel(delegate: self)
    }
    
    private var empresaProveedorViewModel: EmpresaProveedorViewModel {
        EmpresaProveedorViewModel(delegate: self)
    }
    
    var pickerTipoLugar = UIPickerView()
    var rowTipoLugar: [TipoLugarLayer] = []
    var pickerTipoLugarSelected = ""
    
    var pickerAreaComun = UIPickerView()
    lazy var areaComunData = [DataTipoAreaComun]()
    var idAreaComunSelected: Int?
    
    var pickerEmpresaProveedor = UIPickerView()
    lazy var empresaProveedorData = [DataEmpresaProveedor]()
    var idEmpresaProveedorSelected: Int?
    
    
    // MARK: Registro Visita frecuente/eventual
    private var registroVisitaViewModel: RegistroVisitaViewModel {
        RegistroVisitaViewModel(delegate: self)
    }
    
    private var tipoDocumentoViewModel: TipoDocumentoViewModel {
        TipoDocumentoViewModel(delegate: self)
    }
    
    var pickerTipoDocumento = UIPickerView()
    lazy var tipoDocumentoData = [DataTipoDocumento]()
    var idTipoDocumentoSelected: Int?
    
    
    // MARK: Seccion Date & Hour
    let datePicker = UIDatePicker()
    let minDate: Date = Date()
    
    let hourPicker = UIDatePicker()
    var minHour: Date = Date(timeIntervalSince1970: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setDesign
        setScreenDesign()
    }
    
    @IBAction func getImageFromAlbumDui1(_ sender: UIButton) {
        tagSelected = sender.tag
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func getImageFromAlbumDui2(_ sender: UIButton) {
        tagSelected = sender.tag
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func actionRegistroPase(_ sender: Any) {
        
        // validate data
//        validate()
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: self.view)
        
        
        if (pickerTipoRegistroPaseSelected == "1") {
            registroPaseEmpleadoViewModel.requestRegistroPaseEmpleado(body: ["\(txtNombre.text ?? "")","\(txtApellido.text ?? "")","\(txtTelefonoEmpleado.text ?? "")","\(txtDuiEmpleado.text ?? "")","\(imageDataDui1)","\(imageDataDui2)"])
        
        } else if (pickerTipoRegistroPaseSelected == "2") {
            registroPaseProveedorViewModel.requestRegistroPaseProveedor(body: ["\(idEmpresaProveedorSelected ?? 0)","\(txtFecha.text ?? "")","\(txtHora.text ?? "")","\(pickerTipoLugarSelected )","\(idAreaComunSelected ?? 0)","\(txtNombre.text ?? "")","\(txtApellido.text ?? "")","\(txtEmailProveedor.text ?? "")","\(txtTelefonoProveedor.text ?? "")"])
            
        } else  {
           
//            print(["\(pickerTipoRegistroPaseSelected)","\(txtNombre.text ?? "")","\(txtApellido.text ?? "")","\(txtCorreoVisita.text ?? "" )","\(txtFecha.text ?? "")","\(txtHora.text ?? "")","\(txtTelefonoVisita.text ?? "")","\(pickerTipoLugarSelected)","\(idAreaComunSelected ?? 0)","\(idTipoDocumentoSelected ?? 0)","\(txtNumeroDuiVisita.text ?? "")","\(txtNumeroPlacaVisita.text ?? "")"])
            registroVisitaViewModel.requestRegistroVisita(body: ["\(pickerTipoRegistroPaseSelected)","\(txtNombre.text ?? "")","\(txtApellido.text ?? "")","\(txtCorreoVisita.text ?? "" )","\(txtFecha.text ?? "")","\(txtHora.text ?? "")","\(txtTelefonoVisita.text ?? "")","\(pickerTipoLugarSelected)","\(idAreaComunSelected ?? 0)","\(idTipoDocumentoSelected ?? 0)","\(txtNumeroDuiVisita.text ?? "")","\(txtNumeroPlacaVisita.text ?? "")"])
        }
        
        
    }
    
    //hide / show container with respect tipo de visita
    private func changeViewTipoRegistroPase(paramIdTipoRegistroPase: String) {
        
        switch paramIdTipoRegistroPase {
            case "1":
                print("empleado selected")
                containerNombre.isHidden = false
                constraintContainerNombre.constant = 85
                containerApellido.isHidden = false
                constraintContainerApellido.constant = 85
                containerDocumentoImagen.isHidden = false
                constraintContainerDocumentoImagen.constant = 140
                containerEmpleado.isHidden = false
                constraintContainerEmpleado.constant = 178
                containerProveedor.isHidden = true
                
                constraintContainerProveedor.constant = 0
                containerVisita.isHidden = true
                constraintContainerVisita.constant = 0
                containerAreaProveedor.isHidden = true
                constraintContainerAreaProveedor.constant = 0
                containerAreaVisita.isHidden = true
                constraintContainerAreaVisita.constant = 0
                containerDate.isHidden = true
                constraintContainerDate.constant = 0
            case "2":
                print("proveedor selected")
//                containerProveedor.layoutIfNeeded()
                containerNombre.isHidden = false
                constraintContainerNombre.constant = 85
                containerApellido.isHidden = false
                constraintContainerApellido.constant = 85
                containerDocumentoImagen.isHidden = true
                constraintContainerDocumentoImagen.constant = 0
                containerProveedor.isHidden = false
//                view.sendSubviewToBack(containerProveedor)
//                containerProveedor.topAnchor.constraint(equalTo: containerTipoVisita.bottomAnchor, constant: 10).isActive = true
                constraintContainerProveedor.constant = 461
                constraintContainerProveedorTopAnchor.constant = -7
                containerEmpleado.isHidden = true
                constraintContainerEmpleado.constant = 0
                containerVisita.isHidden = true
                constraintContainerVisita.constant = 0
                containerAreaProveedor.isHidden = true
                constraintContainerAreaProveedor.constant = 0
                containerAreaVisita.isHidden = true
                constraintContainerAreaVisita.constant = 0
                containerDate.isHidden = false
                constraintContainerDate.constant = 178
            default:
                print("vFrecuente o Eventual selected")
                containerNombre.isHidden = false
                constraintContainerNombre.constant = 85
                containerApellido.isHidden = false
                constraintContainerApellido.constant = 85
                containerDocumentoImagen.isHidden = true
                constraintContainerDocumentoImagen.constant = 0
                containerProveedor.isHidden = true
                constraintContainerProveedor.constant = 0
                containerEmpleado.isHidden = true
                constraintContainerEmpleado.constant = 0
                containerVisita.isHidden = false
                constraintContainerVisita.constant = 558
                constraintContainerVisitaTopAnchor.constant = 8
                containerAreaProveedor.isHidden = true
                constraintContainerAreaProveedor.constant = 0
                containerAreaVisita.isHidden = true
                constraintContainerAreaVisita.constant = 0
                containerDate.isHidden = false
                constraintContainerDate.constant = 178
        }
        
    }
}

extension RegistroPaseViewController {
    
    private func setScreenDesign(){
        
        changeViewTipoRegistroPase(paramIdTipoRegistroPase: "1")
        
        containerGeneralForm.cornerRadiusViewBorder(bcColor: .white, borderRadius: Constants.App.cornerRadius)
        
        //delegate to UIPickerImage
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    
        createPickerTipoRegistroPase()
        self.txtTipoRegistroPase.aDefaultTxt()
        
        self.txtNombre.aDefaultTxt()
        self.txtApellido.aDefaultTxt()
        
        self.txtTelefonoEmpleado.aPhoneTxt()
        self.txtDuiEmpleado.aDefaultTxt()
        
        createPickerTipoLugar()
        self.txtLugarProveedor.aPhoneTxt()
        createPickerAreaComun()
        self.txtAreaProveedor.aDefaultTxt()
        createPickerEmpresaProveedor()
        self.txtEmpresaProveedor.aDefaultTxt()
        self.txtEmailProveedor.aEmailTxt()
        self.txtTelefonoProveedor.aPhoneTxt()
        
        self.txtCorreoVisita.aEmailTxt()
        self.txtTelefonoVisita.aPhoneTxt()
        self.txtLugarVisita.aDefaultTxt()
        self.txtAreaVisita.aDefaultTxt()
        createPickerTipoDocumento()
        self.txtTipoDocumentoVisita.aDefaultTxt()
        
        self.txtNumeroDuiVisita.aDefaultTxt()
        self.txtNumeroPlacaVisita.aDefaultTxt()
        
        createDatePicker()
        self.txtFecha.aDefaultTxt()
        createHourPicker()
        self.txtHora.aDefaultTxt()
        
        self.btnRegistroPase.cornerButton(borderRadius: Constants.App.cornerRadiusButton)
    }
    
    private func createPickerTipoRegistroPase() {
        
        rowTipoRegistroPase.append(contentsOf: [.empleado, .proveedor, .visitaFrecuente, .visitaEventual])
        
        pickerTipoRegistroPase.delegate = self
        pickerTipoRegistroPase.dataSource = self
        self.txtTipoRegistroPase.inputView = pickerTipoRegistroPase
        
        pickerTipoRegistroPaseSelected = "\(rowTipoRegistroPase.first?.value ?? "1")"
        self.txtTipoRegistroPase.text = "\(rowTipoRegistroPase.first?.name ?? "Empleado")"
        
    }
    
    private func createPickerTipoLugar() {
        
        rowTipoLugar.append(contentsOf: [.casa, .areaComun])
        
        pickerTipoLugar.delegate = self
        pickerTipoLugar.dataSource = self
        self.txtLugarProveedor.inputView = pickerTipoLugar
        self.txtLugarVisita.inputView = pickerTipoLugar
        
        pickerTipoLugarSelected = "\(rowTipoLugar.first?.value ?? "0")"
        self.txtLugarProveedor.text = "\(rowTipoLugar.first?.name ?? "Mi casa")"
        self.txtLugarVisita.text = "\(rowTipoLugar.first?.name ?? "Mi casa")"
        
    }
    
    private func createPickerAreaComun() {
        
        tipoAreaComunViewModel.requestTipoAreaComun()
        
        pickerAreaComun.delegate = self
        pickerAreaComun.dataSource = self
        self.txtAreaProveedor.inputView = pickerAreaComun
        self.txtAreaVisita.inputView = pickerAreaComun
    }
    
    private func createPickerEmpresaProveedor() {
        
        empresaProveedorViewModel.requestEmpresaProveedor()
        
        pickerEmpresaProveedor.delegate = self
        pickerEmpresaProveedor.dataSource = self
        self.txtEmpresaProveedor.inputView = pickerEmpresaProveedor
        
    }
    
    private func createPickerTipoDocumento() {
        
        tipoDocumentoViewModel.requestTipoDocumento()
        
        pickerTipoDocumento.delegate = self
        pickerTipoDocumento.dataSource = self
        self.txtTipoDocumentoVisita.inputView = pickerTipoDocumento
    }
    
    private func createDatePicker(){
        
        //Design Date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        //Formate Date
        datePicker.minimumDate = minDate
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Aceptar", style: .done, target: self, action: #selector(doneDatePicker))
        toolbar.setItems([doneButton], animated: false)
        
        // add toolbar to textField
        txtFecha.inputAccessoryView = toolbar
        // add datepicker to textField
        txtFecha.inputView = datePicker
        
    }
    
    @objc func doneDatePicker(){
        
        //For date formate
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd/MM/yyyy"
        txtFecha.text = formatter.string(from: datePicker.date)
        
//        minHour = datePicker.date
        
        //You can use different datePicker object to set below endDate as +90 days because if you you same date picker it will always add selected date +90 days to date picker.
//           let addDays: TimeInterval = (60 * 60 * 24 * 89) //Add 89 Days

           //Set Start Date as choosen Date
//            hourPicker.minimumDate = minHour

           //Set Max Date as choosen Date + 89 Days
//            hourPicker.maximumDate = Date(timeInterval: addDays, since: minHour)
        
        
//        minHour = formatter.date(from: txtFecha.text ?? "") ?? Date()
        
//        hourPicker.maximumDate = Calendar.current.date(byAdding: .hour, value: 1, to: minHour)
        
        //dismiss date picker dialog
        self.view.endEditing(true)
        
    }
    
    private func createHourPicker(){
        
        //Design Date
        if #available(iOS 13.4, *) {
            hourPicker.preferredDatePickerStyle = .wheels
        }
        
        //Formate Date
        hourPicker.datePickerMode = .time
        hourPicker.minuteInterval = 30
//        hourPicker.minimumDate = minHour
//        if minDate < minHour {
//            hourPicker.minimumDate = minHour
//            print("--> \(minDate)  -- \(minHour) <---")
//        }
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Aceptar", style: .done, target: self, action: #selector(doneHourPicker))
        toolbar.setItems([doneButton], animated: false)
        
        // add toolbar to textField
        txtHora.inputAccessoryView = toolbar
        // add datepicker to textField
        txtHora.inputView = hourPicker
        
    }
    
    @objc func doneHourPicker(){
        
        //For date formate
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "hh:mm a"
        txtHora.text = formatter.string(from: hourPicker.date)
        
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
}

extension RegistroPaseViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
            case pickerTipoRegistroPase:
                return rowTipoRegistroPase.count
            case pickerTipoLugar:
                return rowTipoLugar.count
            case pickerAreaComun:
                return areaComunData.count
            case pickerEmpresaProveedor:
                return empresaProveedorData.count
            default:
                return tipoDocumentoData.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
            case pickerTipoRegistroPase:
                return rowTipoRegistroPase[row].name
            case pickerTipoLugar:
                return rowTipoLugar[row].name
            case pickerAreaComun:
                return areaComunData[row].name
            case pickerEmpresaProveedor:
                return empresaProveedorData[row].name
            default:
                return tipoDocumentoData[row].name
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
            case pickerTipoRegistroPase:
                pickerTipoRegistroPaseSelected = rowTipoRegistroPase[row].value
                txtTipoRegistroPase.text = rowTipoRegistroPase[row].name
                
                changeViewTipoRegistroPase(paramIdTipoRegistroPase: pickerTipoRegistroPaseSelected)
                
            case pickerTipoLugar:
                
                pickerTipoLugarSelected = rowTipoLugar[row].value
                txtLugarProveedor.text = rowTipoLugar[row].name
                txtLugarVisita.text = rowTipoLugar[row].name
                
                if (pickerTipoLugarSelected == "0") {
                    containerAreaProveedor.isHidden = true
                    constraintContainerAreaProveedor.constant = 0
                    containerAreaVisita.isHidden = true
                    constraintContainerAreaVisita.constant = 0
                    txtAreaProveedor.text = ""
                    txtAreaVisita.text = ""
                    idAreaComunSelected = 0
                
                } else {
                    
                    containerAreaProveedor.isHidden = false
                    constraintContainerAreaProveedor.constant = 85
                    containerAreaVisita.isHidden = false
                    constraintContainerAreaVisita.constant = 85
                    txtAreaProveedor.text = areaComunData.first?.name
                    txtAreaVisita.text = areaComunData.first?.name
                    idAreaComunSelected = areaComunData.first?.id
                }
                
            case pickerAreaComun:
                
                txtAreaProveedor.text = areaComunData[row].name
                txtAreaVisita.text = areaComunData[row].name
                idAreaComunSelected = areaComunData[row].id
                view.endEditing(true)
                
            case pickerEmpresaProveedor:
                
                txtEmpresaProveedor.text = empresaProveedorData[row].name
                idEmpresaProveedorSelected = empresaProveedorData[row].id
                view.endEditing(true)
                
            default:
                
                txtTipoDocumentoVisita.text = tipoDocumentoData[row].name
                idTipoDocumentoSelected = tipoDocumentoData[row].id
                view.endEditing(true)
        }
        
        view.endEditing(true)
        
    }
    
}

extension RegistroPaseViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        
        guard let image = image else {
            return
        }
        
        if (tagSelected == 1) {
            self.imageDuiFrontal.image = image
            self.imageDuiFrontal.makeRounded()
            let imageQualityAvatar:NSData = (imageDuiFrontal.image?.jpegData(compressionQuality: 0))! as NSData
            imageDataDui1 = "data:image/jpeg;base64," + imageQualityAvatar.base64EncodedString(options: .lineLength64Characters)
    //        AppData.sharedData.saveImageRegistro(image64: imageDataAvatar)
    //        print("button cancel 1 \(imageDataAvatar)")
        } else {
            
            self.imageDuiReverso.image = image
            self.imageDuiReverso.makeRounded()
            let imageQualityAvatar:NSData = (imageDuiReverso.image?.jpegData(compressionQuality: 0))! as NSData
            imageDataDui2 = "data:image/jpeg;base64," + imageQualityAvatar.base64EncodedString(options: .lineLength64Characters)
        }
        
        
        
        
    }
}

// MARK: Registro empleado
extension RegistroPaseViewController: RegistroPaseEmpleadoDelegate {
    func registroRequestCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: "Registro exitoso", title: "Mensaje")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func registroRequestCompleted(with error: String) {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: error, title: "Error")
            
        }
    }
    

}

// MARK: Registro proveedor
extension RegistroPaseViewController: TipoAreaComunDelegate {
    func tipoAreaComunRequestCompleted() {
        print("areas comunes cargadas")
        DispatchQueue.main.async {
            self.areaComunData = GlobalParameters.instance().globalDataTipoAreaComun
            
            guard !self.areaComunData.isEmpty else {
                print("adentro de guard area")
                self.txtAreaProveedor.isEnabled = false
                self.txtAreaProveedor.text = ""
                self.txtAreaVisita.isEnabled = false
                self.txtAreaVisita.text = ""
                return
            }
            print("afuera de guard vivienda")
            
            self.txtAreaProveedor.text = self.areaComunData.first?.name
            self.txtAreaVisita.text = self.areaComunData.first?.name
        }
    }
    
    func tipoAreaComunRequestCompleted(with error: String) {
        DispatchQueue.main.async {
            self.txtAreaProveedor.isEnabled = false
            self.txtAreaVisita.isEnabled = false
            
        }
    }
    
}

extension RegistroPaseViewController: EmpresaProveedorDelegate {
    func empresaProveedorRequestCompleted() {
        print("empresa cargadas")
        DispatchQueue.main.async {
            self.empresaProveedorData = GlobalParameters.instance().globalDataEmpresaProveedor
            
            guard !self.empresaProveedorData.isEmpty else {
                print("adentro de guard vivienda")
                self.txtEmpresaProveedor.isEnabled = false
                self.txtEmpresaProveedor.text = ""
                return
            }
            print("afuera de guard vivienda")
            
            self.txtEmpresaProveedor.text = self.empresaProveedorData.first?.name
            self.idEmpresaProveedorSelected = self.empresaProveedorData.first?.id
            
        }
    }
    
    func empresaProveedorRequestCompleted(with error: String) {
        DispatchQueue.main.async {
            self.txtEmpresaProveedor.isEnabled = false
            
        }
    }
    
}

extension RegistroPaseViewController: RegistroPaseProveedorDelegate {
    func RegistroPaseProveedorRequestCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: "Registro exitoso", title: "Mensaje")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func RegistroPaseProveedorRequestCompleted(with error: String) {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: error, title: "Error")
            
        }
    }
    
}

// MARK: Registro Visita frecuente/eventual
extension RegistroPaseViewController: RegistroVisitaDelegate {
    func registroVisitaRequestCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: "Registro exitoso", title: "Mensaje")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func registroVisitaRequestCompleted(with error: String) {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: error, title: "Error")
            
        }
    }
    
    
}

extension RegistroPaseViewController: TipoDocumentoDelegate {
    func tipoDocumentoRequestCompleted() {
        DispatchQueue.main.async {
            self.tipoDocumentoData = GlobalParameters.instance().globalDataTipoDocumento
            
            guard !self.tipoDocumentoData.isEmpty else {
                print("adentro de guard tipodicuemnto")
                self.txtTipoDocumentoVisita.isEnabled = false
                self.txtTipoDocumentoVisita.text = ""
                return
            }
            print("afuera de guard tipodicumento")
            
            self.txtTipoDocumentoVisita.text = self.tipoDocumentoData.first?.name
            self.idTipoDocumentoSelected = self.tipoDocumentoData.first?.id
        }
    }
    
    func tipoDocumentoRequestCompleted(with error: String) {
        DispatchQueue.main.async {
            self.txtTipoDocumentoVisita.isEnabled = false
            
        }
    }
    
       
}

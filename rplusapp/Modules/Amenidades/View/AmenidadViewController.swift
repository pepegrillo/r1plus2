//
//  AmenidadViewController.swift
//  rplusapp
//
//  Created by Josué López on 12/7/20.
//

import UIKit

class AmenidadViewController: UIViewController {
    
    
    @IBOutlet weak var containerForm1: UIView!
    @IBOutlet weak var txtAreaAmenidades: UITextField!
    @IBOutlet weak var txtFecha: UITextField!
    @IBOutlet weak var txtHora: UITextField!
    
    @IBOutlet weak var btnRegistroAmenidades: UIButton!
    
    // MARK: Areas comunes
    private var tipoAreaComunViewModel: TipoAreaComunViewModel {
        TipoAreaComunViewModel(delegate: self)
    }
    
    var pickerAreaComun = UIPickerView()
    lazy var areaComunData = [DataTipoAreaComun]()
    var idAreaComunSelected: Int?
    
    // MARK: Seccion Date & Hour
    let datePicker = UIDatePicker()
    let minDate: Date = Date()
    
    let hourPicker = UIDatePicker()
    var minHour: Date = Date(timeIntervalSince1970: 0)
    
    // MARK: Registro reserva amenidad
    private var amenidadViewModel: AmenidadViewModel {
        AmenidadViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.visibleViewController?.title = "Amenidades"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setDesign
        setScreenDesign()
    }
    
    @IBAction func actionReservar(_ sender: UIButton) {
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: self.view)
        amenidadViewModel.requestAmenidad(body: ["\(idAreaComunSelected ?? 0)","\(txtFecha.text ?? "")","\(txtHora.text ?? "")"])
    }
}

extension AmenidadViewController {
    
    private func setScreenDesign(){
        
        containerForm1.cornerRadiusViewBorder(bcColor: .white, borderRadius: Constants.App.cornerRadius)
        
        createPickerAreaComun()
        self.txtAreaAmenidades.aDefaultTxt()
        
        createDatePicker()
        self.txtFecha.aDefaultTxt()
        createHourPicker()
        self.txtHora.aDefaultTxt()
        
        self.btnRegistroAmenidades.cornerButton(borderRadius: Constants.App.cornerRadiusButton)
    }
    
    private func createPickerAreaComun() {
        
        tipoAreaComunViewModel.requestTipoAreaComun()
        
        pickerAreaComun.delegate = self
        pickerAreaComun.dataSource = self
        self.txtAreaAmenidades.inputView = pickerAreaComun
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

extension AmenidadViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
                return areaComunData.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
                return areaComunData[row].name
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
                txtAreaAmenidades.text = areaComunData[row].name
                idAreaComunSelected = areaComunData[row].id
                view.endEditing(true)
    
    }
    
}

// MARK: Registro proveedor
extension AmenidadViewController: TipoAreaComunDelegate {
    func tipoAreaComunRequestCompleted() {
        print("areas comunes cargadas")
        DispatchQueue.main.async {
            self.areaComunData = GlobalParameters.instance().globalDataTipoAreaComun
            
            guard !self.areaComunData.isEmpty else {
                print("adentro de guard area")
                self.txtAreaAmenidades.isEnabled = false
                self.txtAreaAmenidades.text = ""
                
                return
            }
            print("afuera de guard vivienda")
            
            self.txtAreaAmenidades.text = self.areaComunData.first?.name
            self.idAreaComunSelected = self.areaComunData.first?.id
        }
    }
    
    func tipoAreaComunRequestCompleted(with error: String) {
        DispatchQueue.main.async {
            self.txtAreaAmenidades.isEnabled = false
            
        }
    }
    
}

extension AmenidadViewController: AmenidadDelegate {
    func amenidadRequestCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: "Reserva exitosa", title: "Mensaje")
            
        }
    }
    
    func amenidadRequestCompleted(with error: String) {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: error, title: "Error")
            
        }
    }
    
}

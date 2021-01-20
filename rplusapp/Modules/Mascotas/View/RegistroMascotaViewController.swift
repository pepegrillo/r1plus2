//
//  RegistroMascotaViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/19/20.
//

import UIKit

class RegistroMascotaViewController: UIViewController {
    
    // MARK: - Registro Mascota Outlets
    @IBOutlet weak var containerForm1: UIView!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtTipoMascota: UITextField!
    @IBOutlet weak var txtRaza: UITextField!
    @IBOutlet weak var txtDescripcion: UITextField!
    @IBOutlet weak var imgAvatar: UIImageView!
    
    @IBOutlet weak var btnRegisterMascota: UIButton!
    
    // picker Tipo Mascota
    var pickerTipoMascota = UIPickerView()
    lazy var tipoMascotaData = [DataTipoMascota]()
    
    var idTipoMascotaSelected: Int?
    
    private var tipoMascotaViewModel: TipoMascotaViewModel {
        TipoMascotaViewModel(delegate: self)
    }
    
    //picker select image
    var imagePicker: ImagePicker!
    var imageDataAvatar: String = ""
    
    // register mascota
    private var registroMascotaViewModel: RegistroMascotaViewModel {
        RegistroMascotaViewModel(delegate: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set data
        tipoMascotaViewModel.requestTipoMascota()
        
        //set design
        setScreenDesign()
    }
    
    //call get image
    @IBAction func getImageFromAlbum(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func actionRegistroMascota(_ sender: Any) {
        
        // validate data
        validate()
    }
}

extension RegistroMascotaViewController {
    
    //set design
    private func setScreenDesign() {
        
        containerForm1.cornerRadiusViewBorder(bcColor: .white, borderRadius: Constants.App.cornerRadius)
        
        txtTipoMascota.isEnabled = false
        createPickerTipoMascota()
        
        //delegate to UIPickerImage
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        self.txtNombre.aDefaultTxt()
        self.txtTipoMascota.aDefaultTxt()
        self.txtRaza.aDefaultTxt()
        self.txtDescripcion.aDefaultTxt()
        
        self.btnRegisterMascota.cornerButton(borderRadius: Constants.App.cornerRadiusButton)
    }
    
    //create picker
    private func createPickerTipoMascota() {
        
        pickerTipoMascota.delegate = self
        pickerTipoMascota.dataSource = self
        self.txtTipoMascota.inputView = pickerTipoMascota
        
    }
    
    //validate form
    private func validate() {
        do {
            
            let  vNombre = try txtNombre.validatedText(validationType: ValidatorType.requiredField(field: "Nombre", min: 1))
            _ = try txtTipoMascota.validatedText(validationType: ValidatorType.requiredField(field: "Tipo mascota", min: 1))
            let  vRaza = try txtRaza.validatedText(validationType: ValidatorType.requiredField(field: "Raza", min: 1))
            
            
            guard (imageDataAvatar != "") else {
                AlertManager.showAlert(withMessage: "Imagen de mascota es campo obligatorio", title: "Advertencia")
                return
            }
            
            let group = DispatchGroup()
            group.enter()
            DispatchQueue.main.async {
                print("------- 1")
                ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: self.view)
                group.leave()
            }
            group.enter()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                print("------- 2")
                self.registroMascotaViewModel.requestRegistroMascota(body: [vNombre,"\(self.idTipoMascotaSelected ?? 0)", vRaza, "\(self.txtDescripcion.text ?? "")","\(self.imageDataAvatar)"])
                group.leave()
            }
            
            group.notify(queue: .main) {
                // Alert
                print("------- 3 notify")
            }
            
            
        } catch(let error) {
            AlertManager.showAlert(withMessage: (error as! ValidationError).message, title: "Advertencia")
        }
    }
    
}

extension RegistroMascotaViewController: TipoMascotaDelegate {
    func tipoMascotaCompleted() {
        DispatchQueue.main.async {
            self.tipoMascotaData = GlobalParameters.instance().globalDataTipoMascota
            
            guard !self.tipoMascotaData.isEmpty else {
                
                self.txtTipoMascota.isEnabled = false
                self.txtTipoMascota.text = ""
                return
            }
            
            self.txtTipoMascota.isEnabled = true
            self.txtTipoMascota.text = self.tipoMascotaData.first?.name
            self.idTipoMascotaSelected = self.tipoMascotaData.first?.id
        }
    }
    
    func tipoMascotaCompleted(with error: String) {
        DispatchQueue.main.async {
            self.txtTipoMascota.isEnabled = false
            
        }
    }
    
}

extension RegistroMascotaViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return tipoMascotaData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return tipoMascotaData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        txtTipoMascota.text = tipoMascotaData[row].name
        idTipoMascotaSelected = tipoMascotaData[row].id
        view.endEditing(true)
    }
    
    // MARK: TextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
}

extension RegistroMascotaViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        
        guard let image = image else {
            return
        }
        
        self.imgAvatar.image = image
        self.imgAvatar.makeRounded()
        let imageQualityAvatar:NSData = (imgAvatar.image?.jpegData(compressionQuality: 0))! as NSData
        imageDataAvatar = "data:image/jpeg;base64," + imageQualityAvatar.base64EncodedString(options: .lineLength64Characters)
        
    }
}


extension RegistroMascotaViewController: RegistroMascotaDelegate {
    func registroMascotaCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: "Registro exitoso", title: "Mensaje")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func registroMascotaCompleted(with error: String) {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: error, title: "Error")
            
        }
    }
    
    
}

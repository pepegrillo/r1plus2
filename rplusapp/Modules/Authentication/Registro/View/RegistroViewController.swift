//
//  RegistroViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/23/20.
//

import UIKit
import GoogleSignIn

class RegistroViewController: UIViewController {
    
    @IBOutlet weak var constraintContainerPassword: NSLayoutConstraint!
    @IBOutlet weak var constraintContainerRePassword: NSLayoutConstraint!
    @IBOutlet weak var containerPassword: UIView!
    @IBOutlet weak var containerRePassword: UIView!
    
    @IBOutlet weak var containerForm1: UIView!
    @IBOutlet weak var containerForm2: UIView!
    @IBOutlet weak var txtTipoUsuario: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtPhoneExtra: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPasswordConfirm: UITextField!
    @IBOutlet weak var imgAvatar: UIImageView!
    
    @IBOutlet weak var btnRegisterUser: UIButton!
    
    var pickerTipoUsuario = UIPickerView()
    lazy var tipoUsuarioData = [DataTipoUsuario]()
    
    var idTipoUsuarioSelected: Int?
    
    private var tipoUsuarioViewModel: TipoUsuarioViewModel {
        TipoUsuarioViewModel(delegate: self)
    }
    
    var imagePicker: ImagePicker!
    var imageDataAvatar: String = ""
    
    private var registroViewModel: RegistroViewModel {
        RegistroViewModel(delegate: self)
    }
    
    // MARK: Facebook parameters
    var idSocialLogin: Int = 0
    var idPasswordToken: String = ""
    var idSocialId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set design
        setScreenDesign()
        
        //set data
        tipoUsuarioViewModel.requestTipoUsuario()
        
        //set info from SocialLogin
        setDataFromApple()
        setDataFromGoogle()
        setDataFromFacebook()
        
        
    }
    
    @IBAction func getImageFromAlbum(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func actionHome(_ sender: Any) {
        
        // validate data
        validate()
    }
}

extension RegistroViewController {
    
    //set design
    private func setScreenDesign() {
        
        containerForm1.cornerRadiusViewBorder(bcColor: .white, borderRadius: Constants.App.cornerRadius)
        containerForm2.cornerRadiusViewBorder(bcColor: .white, borderRadius: Constants.App.cornerRadius)
        txtTipoUsuario.isEnabled = false
        createPickerTipoUsuario()
        
        //delegate to UIPickerImage
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        self.txtTipoUsuario.aDefaultTxt()
        self.txtNombre.aDefaultTxt()
        self.txtApellido.aDefaultTxt()
        self.txtEmail.aEmailTxt()
        self.txtPhone.aPhoneTxt()
        self.txtPhoneExtra.aPhoneTxt()
        self.txtPassword.aPasswordTxt()
        self.txtPasswordConfirm.aPasswordTxt()
        
        // hide password fields if necessary
        hidePaswordFields()
        
        self.btnRegisterUser.cornerButtonColors(bcColor: Constants.PaletteColors.colorFirst, borderRadius: Constants.App.cornerRadiusButton)
    }
    
    //create picker
    private func createPickerTipoUsuario() {
        
        pickerTipoUsuario.delegate = self
        pickerTipoUsuario.dataSource = self
        self.txtTipoUsuario.inputView = pickerTipoUsuario
        
    }
    
    // hide password & confirm password fields
    private func hidePaswordFields(){
        
        if idSocialLogin != 0  {
            self.containerPassword.isHidden = true
            self.containerRePassword.isHidden = true
            
            self.constraintContainerPassword.constant = 0
            self.constraintContainerRePassword.constant = 0
        }
        
    }
    
    // set info from Apple
    private func setDataFromApple(){
        
        if idSocialLogin == 2 {
            
            let appleEmail = UserDefaults.standard.string( forKey: "userEmail")
            let appleName = UserDefaults.standard.string( forKey: "userName")
            print("dataApple ---> \(appleName)")
            self.txtNombre.text = appleName
            self.txtApellido.text = appleName
            self.txtEmail.text = appleEmail
        }
    }
    
    // set info from Google
    private func setDataFromGoogle(){
        
        if idSocialLogin == 3 {
            let google = GIDSignIn.sharedInstance()?.currentUser
            
            self.txtNombre.text = google?.profile.givenName
            self.txtApellido.text = google?.profile.familyName
            self.txtEmail.text = google?.profile.email
            let pic = google?.profile.imageURL(withDimension: UInt(round(500)))
            self.imgAvatar.sd_setImage(with: URL(string: pic?.absoluteString ?? ""), completed: {(image, error, cacheType, url) in
                self.imgAvatar.makeRounded()
                
                //set base64
                let imageProfileFb = self.imgAvatar.image
                let imageQualityAvatar:NSData = (imageProfileFb?.jpegData(compressionQuality: 0.8))! as NSData
                self.imageDataAvatar = "data:image/jpeg;base64," + imageQualityAvatar.base64EncodedString(options: .lineLength64Characters)
                
                print("button cancel 1 \(self.imageDataAvatar)")
            })
        }
    }
    
    // set info from facebook
    private func setDataFromFacebook(){
        
        if idSocialLogin == 4 {
            let fb: [String: AnyObject] = UserDefaults.standard.object(forKey: Constants.App.bdFacebookData) as! [String : AnyObject]
            
            self.txtNombre.text = fb["name"] as? String
            self.txtApellido.text = fb["last_name"] as? String
            self.txtEmail.text = fb["email"] as? String
            self.imgAvatar.sd_setImage(with: URL(string: fb["pictureFbUrl"] as? String ?? ""), completed: {(image, error, cacheType, url) in
                self.imgAvatar.makeRounded()
                
                //set base64
                if let imageProfileFb = self.imgAvatar.image {
                    let imageQualityAvatar:NSData = (imageProfileFb.jpegData(compressionQuality: 1))! as NSData
                    self.imageDataAvatar = "data:image/jpeg;base64," + imageQualityAvatar.base64EncodedString(options: .lineLength64Characters)
                    
                    print("button cancel 1 \(self.imageDataAvatar)")
                }
            })
            
        }
    }
    
    // go to VerificationCode
    private func goToVerificarCodigo(){
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "VerificarCodigoViewController") as! VerificarCodigoViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //validate form
    private func validate() {
        do {
            _ = try txtTipoUsuario.validatedText(validationType: ValidatorType.requiredField(field: "Tipo usuario", min: 1))
            let  vNombre = try txtNombre.validatedText(validationType: ValidatorType.requiredField(field: "Nombre", min: 1))
            let  vApellido = try txtApellido.validatedText(validationType: ValidatorType.requiredField(field: "Apellido", min: 1))
            let  vEmail = try txtEmail.validatedText(validationType: ValidatorType.email)
            let  vPhone = try txtPhone.validatedText(validationType: ValidatorType.requiredField(field: "Numero de telefono", min: 8))
            let  vPhoneExtra = try txtPhoneExtra.validatedText(validationType: ValidatorType.requiredField(field: "Numero de telefono", min: 8))
            
            //block if push come from social network login
            var  vPassword = ""
            var  vPasswordConfirm = ""
            
            print(idSocialLogin)
            
            if idSocialLogin == 0 {
                
                vPassword = try txtPassword.validatedText(validationType: ValidatorType.password)
                
                guard (self.txtPasswordConfirm.text == vPassword) else {
                    AlertManager.showAlert(withMessage: "Los campos contraseñas no son iguales", title: "Advertencia")
                    return
                }
                vPasswordConfirm = try txtPasswordConfirm.validatedText(validationType: ValidatorType.password)
                
                
            } else {
                
                vPassword = idSocialId
                vPasswordConfirm = idSocialId
                
            }
            
            
            guard (imageDataAvatar != "") else {
                AlertManager.showAlert(withMessage: "Imagen de perfil es campo obligatorio", title: "Advertencia")
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
                if self.idSocialLogin == 2 { //Apple
                    
                    let appleId = UserDefaults.standard.string(forKey: "Apple_ID")
                    let appleAuthCode = UserDefaults.standard.string(forKey: "Apple_AuthCode")
                    let appleScope = UserDefaults.standard.string(forKey: "Apple_Scope")
                    let appleState = UserDefaults.standard.string(forKey: "Apple_State")
                    
                    
                    self.registroViewModel.requestRegistro(body: [vNombre,vApellido,vEmail,vPassword,vPasswordConfirm,vPhone,vPhoneExtra,"12rwfasdfsdfasdf","2",String(self.idTipoUsuarioSelected ?? 1),"2","\(appleId ?? "")",self.idPasswordToken,"\(appleAuthCode ?? "")","\(appleScope ?? "")","\(appleState ?? "")","","","","",self.imageDataAvatar])
                    
                } else if self.idSocialLogin == 3 { //Google
                    let googleId = UserDefaults.standard.string(forKey: "Google_ID")
                    
                    self.registroViewModel.requestRegistro(body: [vNombre,vApellido,vEmail,vPassword,vPasswordConfirm,vPhone,vPhoneExtra,"12rwfasdfsdfasdf","2",String(self.idTipoUsuarioSelected ?? 1),"3","","","","","","\(googleId ?? "")",self.idPasswordToken,"","",self.imageDataAvatar])
                    
                } else if self.idSocialLogin == 4 { //Facebook
                    let facebookId = UserDefaults.standard.string(forKey: "Facebook_ID")
                    
                    self.registroViewModel.requestRegistro(body: [vNombre,vApellido,vEmail,vPassword,vPasswordConfirm,vPhone,vPhoneExtra,"12rwfasdfsdfasdf","2",String(self.idTipoUsuarioSelected ?? 1),"4","","","","","","","","\(facebookId ?? "")",self.idPasswordToken,self.imageDataAvatar])
                    
                } else { //personal RPlus
                    
                    self.registroViewModel.requestRegistro(body: [vNombre,vApellido,vEmail,vPassword,vPasswordConfirm,vPhone,vPhoneExtra,"12rwfasdfsdfasdf","2",String(self.idTipoUsuarioSelected ?? 1),"1","","","","","","","","","",self.imageDataAvatar])
                }
                
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

extension RegistroViewController: TipoUsuarioDelegate {
    func tipoUsuarioCompleted() {
        DispatchQueue.main.async {
            self.tipoUsuarioData = GlobalParameters.instance().globalDataTipoUsuario
            self.txtTipoUsuario.isEnabled = true
            self.txtTipoUsuario.text = self.tipoUsuarioData.first?.title
        }
    }
    
    func tipoUsuarioCompleted(with error: String) {
        DispatchQueue.main.async {
            self.txtTipoUsuario.isEnabled = false
            self.pickerTipoUsuario.isUserInteractionEnabled = false
            self.tipoUsuarioData = .init()
        }
    }
    
    
}

extension RegistroViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        tipoUsuarioData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return tipoUsuarioData[row].title
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtTipoUsuario.text = tipoUsuarioData[row].title
        idTipoUsuarioSelected = tipoUsuarioData[row].id
        view.endEditing(true)
    }
    
    // MARK: TextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        //        navigationController?.navigationBar.isHidden = false
        return false
    }
    
}

extension RegistroViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        
        guard let image = image else {
            return
        }
        
        
        self.imgAvatar.image = image
        self.imgAvatar.makeRounded()
        let imageQualityAvatar:NSData = (imgAvatar.image?.jpegData(compressionQuality: 0))! as NSData
        imageDataAvatar = "data:image/jpeg;base64," + imageQualityAvatar.base64EncodedString(options: .lineLength64Characters)
        //        AppData.sharedData.saveImageRegistro(image64: imageDataAvatar)
        print("button cancel 1 \(imageDataAvatar)")
        
    }
}

extension RegistroViewController: RegistroDelegate {
    func registroRequestCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: "Usuario Registrado Exitosamente, Favor verficiar PIN enviado a su telefono.", title: "Mensaje")
            sleep(1)
            self.goToVerificarCodigo()
        }
    }
    
    func registroRequestCompleted(with error: String) {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: error, title: "Error")
            
        }
    }
    
    
    
}

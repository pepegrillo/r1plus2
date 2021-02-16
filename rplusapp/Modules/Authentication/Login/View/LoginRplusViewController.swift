//
//  LoginRplusViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/23/20.
//

import UIKit

class LoginRplusViewController: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    private var loginRplusViewModel: LoginRplusViewModel {
        LoginRplusViewModel(delegate: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set design
        setScreenDesign()
        
    }
    @IBAction func actionLogin(_ sender: Any) {
        //validations
        validate()
    }
    
    
    @IBAction func actionPasswordRecovery(_ sender: Any) {
        //validations
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "PasswordRecoveryViewController") as! PasswordRecoveryViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginRplusViewController {
    
    //set design
    private func setScreenDesign() {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.txtUsername.aEmailTxt(placeHolder: "Ingrese su correo")
        self.txtPassword.aPasswordTxt(placeHolder: "Ingrese su contraseña")
        
        self.btnLogin.cornerButtonColors(bcColor: Constants.PaletteColors.colorFirst, borderRadius: Constants.App.cornerRadiusButton)
    }
    
    // MARK: validate form
    private func validate() {
        do {
            let  username = try txtUsername.validatedText(validationType: ValidatorType.email)
            let  password = try txtPassword.validatedText(validationType: ValidatorType.requiredField(field: "Contraseña", min: 1))
            ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
            loginRplusViewModel.requestLoginRplus(body: [username, password, "1", "", "", "", "", "", ""])
        } catch(let error) {
            AlertManager.showAlert(withMessage: (error as! ValidationError).message, title: "Advertencia")
        }
    }
    
    private func goToHome() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NavigationMenuBaseController") as! NavigationMenuBaseController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

extension LoginRplusViewController: LoginRplusDelegate {
    func loginRplusRequestCompleted() {
        
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            self.goToHome()
        }
    }
    
    func loginRplusRequestCompleted(with error: String) {
        ActivityIndicator.sharedIndicator.hideActivityIndicator()
        AlertManager.showAlert(withMessage: error, title: "Error")
    }
    
}

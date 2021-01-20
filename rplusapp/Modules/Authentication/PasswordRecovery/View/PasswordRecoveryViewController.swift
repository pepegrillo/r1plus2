//
//  PasswordRecoveryViewController.swift
//  rplusapp
//
//  Created by Josué López on 12/18/20.
//

import UIKit

class PasswordRecoveryViewController: UIViewController {
    
    @IBOutlet weak var txtTelefono: UITextField!
    
    @IBOutlet weak var btnSiguiente: UIButton!
    
    private var passwordRecoveryViewModel: PasswordRecoveryViewModel {
        PasswordRecoveryViewModel(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set design
        setScreenDesign()
    }
    
    @IBAction func actionSiguiente(_ sender: Any) {
        
        // validate data
        validate()
    }
}

extension PasswordRecoveryViewController {
    
    //set design
    private func setScreenDesign() {
        
        self.txtTelefono.aPhoneTxt()
        self.btnSiguiente.cornerButton(borderRadius: Constants.App.cornerRadiusButton)
    }
    
    private func goToVerificacion() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "VerificarCodigoViewController") as! VerificarCodigoViewController
        vc.idPasswordRecovery = 1
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //validate form
    private func validate() {
        do {
            let  vTelefono = try txtTelefono.validatedText(validationType: ValidatorType.requiredField(field: "Verificar telefono", min: 8))
            
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
                
                self.passwordRecoveryViewModel.requestPasswordRecovery(body: [vTelefono])
                
                
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

extension PasswordRecoveryViewController: PasswordRecoveryDelegate{
    func passwordRecoveryCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            self.goToVerificacion()
        }
    }
    
    func passwordRecoveryCompleted(with error: String) {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: "Telefono no encontrado.", title: "Error")
        }
    }
    
    
}

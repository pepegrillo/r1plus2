//
//  VerificarCodigoViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/24/20.
//

import UIKit

class VerificarCodigoViewController: UIViewController {
    
    @IBOutlet weak var txtVerificarCodigo: UITextField!
    
    @IBOutlet weak var containerPasswordRecovery: UIView!
    @IBOutlet weak var txtPasswordRecovery: UITextField!
    
    @IBOutlet weak var btnVerificarCodigo: UIButton!
    
    //variable weather screen come from Password Recovery
    var idPasswordRecovery = 0
    
    private var verificarCodigoViewModel: VerificarCodigoViewModel {
        VerificarCodigoViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set design
        setScreenDesign()
    }
    
    @IBAction func actionVerificarCodigo(_ sender: Any) {
        
        // validate data
        validate()
    }
}

extension VerificarCodigoViewController {
    
    //set design
    private func setScreenDesign() {
        
        self.txtVerificarCodigo.aNumberTxt()
        self.btnVerificarCodigo.cornerButtonColors(bcColor: Constants.PaletteColors.colorFirst, borderRadius: Constants.App.cornerRadiusButton)
        
        if idPasswordRecovery == 1 {
            self.containerPasswordRecovery.isHidden = false
            self.txtPasswordRecovery.aPasswordTxt()
        }
    }
    
    private func goToHome() {
        //pending
        if idPasswordRecovery == 1 {
            popToFirstVC()
        } else {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "NavigationMenuBaseController") as! NavigationMenuBaseController
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func popToFirstVC() {
        if let firstViewController = self.navigationController?.viewControllers[0] {
            self.navigationController?.popToViewController(firstViewController, animated: true)
        }
    }
    
    //validate form
    private func validate() {
        do {
            let  vVerificarCodigo = try txtVerificarCodigo.validatedText(validationType: ValidatorType.requiredField(field: "Verificar codigo", min: 5))
            
            var vPasswordRecovery = ""
            if idPasswordRecovery == 1 {
                vPasswordRecovery = try txtPasswordRecovery.validatedText(validationType: ValidatorType.password)
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
                if self.idPasswordRecovery == 1 {
                    self.verificarCodigoViewModel.requestVerificarCodigoWithPassword(body: [vVerificarCodigo, vPasswordRecovery])
                } else {
                    self.verificarCodigoViewModel.requestVerificarCodigo(body: [vVerificarCodigo])
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

extension VerificarCodigoViewController: VerificarCodigoDelegate {
    func verificarCodigoCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            self.goToHome()
        }
    }
    
    func verificarCodigoCompleted(with error: String) {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: "Algo ha sucedido, intente de nuevo", title: "Error")
        }
    }
    
    
}

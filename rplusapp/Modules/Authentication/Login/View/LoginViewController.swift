//
//  LoginViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/23/20.
//



// Swift // // Extend the code sample from 6a. Add Facebook Login to Your Code // Add to your viewDidLoad method: loginButton.permissions = ["public_profile", "email"]



import UIKit
import FBSDKLoginKit
import GoogleSignIn
import AuthenticationServices

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginProviderStackView: UIStackView!
    @IBOutlet weak var btnLoginGoogle: UIButton!
    @IBOutlet weak var btnLoginFacebook: UIButton!
    @IBOutlet weak var btnRegistroUser: UIButton!
    @IBOutlet weak var btnLoginUser: UIButton!
    
    private var loginRplusViewModel: LoginRplusViewModel {
        LoginRplusViewModel(delegate: self)
    }
    
    //variable for identify which button pressed
    var tagIdSOcialNetwork = 0
    var keyTokenSocialNetwork = ""
    var keySocialId = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        print("GLOBAL =---> \(GlobalParameters.instance().globalAppleName)")
        print("GLOBAL =---> \(GlobalParameters.instance().globalAppleEmail)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 13.0, *) {
            //            performExistingAccountSetupFlows()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set screen Design
        setScreenDesign()
        
        // if user is saved and logged
        verifySessionSaved()
        
        LoginManager().logOut()
        if isLoggedIn() {
            // User logged fb
            print("Show the ViewController with the logged in user")
        }else{
            // Show Login
            print("Show the Home ViewController")
        }
        
        // MARK: Login Apple
        if #available(iOS 13.0, *) {
            setupProviderLoginView()
        }
        
        // MARK: Login Google
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Register notification to update screen after user successfully signed in
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userDidSignInGoogle(_:)),
                                               name: .signInGoogleCompleted,
                                               object: nil)
        
        
        //getUserProfileGoogle()
        
        // Automatically sign in the user.
        //        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        /*
         // [START_EXCLUDE]
         NotificationCenter.default.addObserver(self, selector: #selector(self.receiveToggleAuthUINotification(_:)), name: NSNotification.Name(rawValue: "ToggleAuthUINotification"), object: nil)
         print("Initialized Swift app...")
         //        statusText.text = "Initialized Swift app..."
         //        toggleAuthUI()
         // [END_EXCLUDE]
         */
        
    }
    
    // MARK:- Notification
    @objc private func userDidSignInGoogle(_ notification: Notification) {
        // Update screen after user successfully signed in
        getUserProfileGoogle()
    }
    
    @IBAction func actionLoginGoogle(_ sender: UIButton) {
        tagIdSOcialNetwork = 3
        keyTokenSocialNetwork = "Google_Token"
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func actionLoginFacebook(_ sender: UIButton) {
        tagIdSOcialNetwork = 4
        keyTokenSocialNetwork = "Facebook_Token"
        self.loginButtonClicked()
    }
    
    @IBAction func actionRegistroUser(_ sender: Any) {
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "RegistroViewController") as! RegistroViewController
        navigationController?.pushViewController(vc, animated: true)
        
        //        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "VerificarCodigoViewController") as! VerificarCodigoViewController
        //        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionLoginRplus(_ sender: Any) {
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "LoginRplusViewController") as! LoginRplusViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Login Google
    @objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
        if notification.name.rawValue == "ToggleAuthUINotification" {
            //          self.toggleAuthUI()
            if notification.userInfo != nil {
                guard let userInfo = notification.userInfo as? [String:String] else { return }
                //            self.statusText.text = userInfo["statusText"]!
                print("\(userInfo["statusText"]!)")
            }
        }
    }
    
    
}

extension LoginViewController {
    
    private func setScreenDesign(){
        //        navigationController?.navigationBar.barTintColor = UIColor(hex: "#ffffff")
        self.loginProviderStackView.cornerRadiusView(borderRadius: Constants.App.cornerRadiusButton)
        self.btnLoginGoogle.cornerButton(borderRadius: Constants.App.cornerRadiusButton)
        self.btnLoginFacebook.cornerButton(borderRadius: Constants.App.cornerRadiusButton)
        self.btnRegistroUser.cornerButton(borderRadius: Constants.App.cornerRadiusButton)
        self.btnLoginUser.cornerButton(borderRadius: Constants.App.cornerRadiusButton)
    }
    
    private func    goToHome() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NavigationMenuBaseController") as! NavigationMenuBaseController
        //        vc.modalPresentationStyle = .fullScreen
        //        self.present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func pushLoginSocialNetwork(paramSocialLogin: Int, paramPasswordToken: String, paramSocialId: String){
        
        let vc = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "RegistroViewController") as! RegistroViewController
        vc.idSocialLogin = paramSocialLogin
        vc.idPasswordToken = UserDefaults.standard.string(forKey: "\(paramPasswordToken)") ?? ""
        vc.idSocialId = paramSocialId
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func verifySessionSaved() {
        guard loginRplusViewModel.isLoggedBefore else {
            if AppData.sharedData.getSaveShowcase() != "1" {
                let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "ShowCaseViewController") as! ShowCaseViewController
                navigationController?.pushViewController(vc, animated: false)
            } 
            return
        }
        
        goToHome()
    }
    
    // MARK: Login Apple
    @available(iOS 13.0, *)
    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.loginProviderStackView.addArrangedSubview(authorizationButton)
    }
    
    // - Tag: perform_appleid_password_request
    /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
    @available(iOS 13.0, *)
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    /// - Tag: perform_appleid_request
    @available(iOS 13.0, *)
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        print("TAG 2 ---------->")
        tagIdSOcialNetwork = 2
        keyTokenSocialNetwork = "Apple_Token"
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // MARK: Login Google
    private func getUserProfileGoogle() {
        
        if let user = GIDSignIn.sharedInstance()?.currentUser {
            // User signed in
            
            // Show greeting message
            print("Hello \(user.profile.givenName!)! ✌️")
            print("Hello \(user.userID!) ✌️")
            //            let pic = user.profile.imageURL(withDimension: UInt(round(500)))
            //print("Hello \(String(describing: pic))! ✌️")
            
            // Hide sign in button
            //            signInButton.isHidden = true
            
            // Show sign out button
            //            signOutButton.isHidden = false
            
            //Calling RegisterViewController
            self.keySocialId = user.userID ?? ""
            UserDefaults.standard.setValue("\(user.userID ?? "")", forKey: "Google_ID")
            UserDefaults.standard.setValue("\(user.authentication.idToken ?? "")", forKey: "Google_Token")
            loginRplusViewModel.requestLoginRplus(body: ["\(user.profile.email ?? "")", "\(user.userID ?? "")", "3", "", "", "\(user.userID ?? "")", "\(user.userID ?? "")", "", ""])
            
            
        } else {
            // User signed out
            
            // Show sign in message
            print("Please sign in... 🙂")
            
            // Show sign in button
            //             signInButton.isHidden = false
            
            // Hide sign out button
            //             signOutButton.isHidden = true
        }
    }
    
    // MARK: FB SDK Login
    func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self, handler: { result, error in
            
            //            if(result?.declinedPermissions != .init()){
            //                AlertManager.showAlert(withMessage: "Los datos solicitados son usados de forma anonima, se solicita aceptar todos los permisos", title: "Advertencia")
            //
            //            } else {
            
            if error != nil {
                print("ERROR: Trying to get login results")
            } else if result?.isCancelled != nil {
                
                print("The token is \(result?.token?.tokenString ?? "")")
                if result?.token?.tokenString != nil {
                    print("Logged in")
                    self.getUserProfile(token: result?.token, userId: result?.token?.userID)
                } else {
                    print("Cancelled")
                }
            }
            //            }
            
            
        })
    }
    
    func getUserProfile(token: AccessToken?, userId: String?) {
        let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, middle_name, last_name, name, picture.type(large), email"])
        graphRequest.start { _, result, error in
            if error == nil {
                var data: [String: AnyObject] = result as! [String: AnyObject]
                
                // Facebook Id
                var getFacebookId = ""
                if let facebookId = data["id"] as? String {
                    getFacebookId = facebookId
                    UserDefaults.standard.setValue("\(facebookId )", forKey: "Facebook_ID")
                    print("Facebook Id: \(facebookId)")
                }
                self.keySocialId = getFacebookId
                
                // Facebook First Name
                if let facebookFirstName = data["first_name"] as? String {
                    print("Facebook First Name: \(facebookFirstName)")
                    self.btnLoginFacebook.setTitle("Sesion iniciada con \(facebookFirstName)", for: .normal)
                } else {
                    print("Facebook First Name: Not exists")
                }
                
                // Facebook Middle Name
                if let facebookMiddleName = data["middle_name"] as? String {
                    print("Facebook Middle Name: \(facebookMiddleName)")
                } else {
                    print("Facebook Middle Name: Not exists")
                }
                
                // Facebook Last Name
                if let facebookLastName = data["last_name"] as? String {
                    print("Facebook Last Name: \(facebookLastName)")
                } else {
                    print("Facebook Last Name: Not exists")
                }
                
                // Facebook Name
                if let facebookName = data["name"] as? String {
                    print("Facebook Name: \(facebookName)")
                } else {
                    print("Facebook Name: Not exists")
                }
                
                // Facebook Profile Pic URL
                let facebookProfilePicURL = "https://graph.facebook.com/\(userId ?? "")/picture?type=large"
                data["pictureFb"] = facebookProfilePicURL as AnyObject
                print("Facebook Profile Pic URL: \(facebookProfilePicURL)")
                let picture = data["picture"] as AnyObject
                let dataPicture = picture["data"] as AnyObject
                let urlPicture = dataPicture["url"] as? String
                data["pictureFbUrl"] = urlPicture as AnyObject
                
                // Facebook Email
                var getFacebookEmail = ""
                if let facebookEmail = data["email"] as? String {
                    getFacebookEmail = facebookEmail
                    print("Facebook Email: \(facebookEmail)")
                }
                
                // set token facebook
                print("Facebook Access Token: \(token?.tokenString ?? "")")
                data["tokenFb"] = "\(token?.tokenString ?? "")" as AnyObject
                UserDefaults.standard.setValue("\(token?.tokenString ?? "")", forKey: "Facebook_Token")
                
                // MARK: Registro Facebook - call function to Log in and register user
                
                //save in UserDefaults
                AppData.sharedData.saveUserFacebookData(data: data)
                
                print("---> \(String(describing: UserDefaults.standard.object(forKey: Constants.App.bdFacebookData)))")
                
                let fb: [String: AnyObject] = UserDefaults.standard.object(forKey: Constants.App.bdFacebookData) as! [String : AnyObject]
                
                print("--> \(String(describing: fb["name"]))")
                
                //Calling REgisterViewController
                self.loginRplusViewModel.requestLoginRplus(body: ["\(getFacebookEmail)", "\(getFacebookId)", "4", "", "", "", "", "\(getFacebookId)", "\(token?.tokenString ?? "")"])
                
                
            } else {
                print("Error: Trying to get user's info")
            }
        }
    }
    
    func isLoggedIn() -> Bool {
        let accessToken = AccessToken.current
        let isLoggedIn = accessToken != nil && !(accessToken?.isExpired ?? false)
        return isLoggedIn
    }
}

extension LoginViewController: LoginRplusDelegate {
    func loginRplusRequestCompleted() {
        
        DispatchQueue.main.async {
            self.goToHome()
        }
    }
    
    func loginRplusRequestCompleted(with error: String) {
        
        DispatchQueue.main.async {
            print("---> \(self.tagIdSOcialNetwork) ----==== \(self.keyTokenSocialNetwork)")
            self.pushLoginSocialNetwork(paramSocialLogin: self.tagIdSOcialNetwork, paramPasswordToken: self.keyTokenSocialNetwork, paramSocialId: self.keySocialId)
            
        }
    }
    
}

// MARK: Login Apple
extension LoginViewController: ASAuthorizationControllerDelegate {
    /// - Tag: did_complete_authorization
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let token = appleIDCredential.identityToken?.base64EncodedString()
            
            
            print("Apple TOKEN ----> \(String(describing: appleIDCredential.identityToken?.base64EncodedString())) ---- \(email ?? "QUEPASA") ----  \(String(describing: appleIDCredential.authorizationCode?.base64EncodedString()))")
            
            
            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
            UserDefaults.standard.set(userIdentifier, forKey: "Apple_ID")
            
            if (email != nil) {
                self.keySocialId = userIdentifier
                UserDefaults.standard.set(email, forKey: "userEmail")
                UserDefaults.standard.set("\(fullName?.givenName ?? "") \(fullName?.familyName ?? "")", forKey: "userName")
                UserDefaults.standard.set("\(appleIDCredential.authorizationCode?.base64EncodedString() ?? "")", forKey: "Apple_AuthCode")
                UserDefaults.standard.set("\(appleIDCredential.authorizationCode?.base64EncodedString() ?? "")", forKey: "Apple_Scope")
                UserDefaults.standard.set("\(appleIDCredential.authorizationCode?.base64EncodedString() ?? "")", forKey: "Apple_State")
                
                GlobalParameters.instance().globalAppleName = UserDefaults.standard.string(forKey: "userName") ?? ""
                GlobalParameters.instance().globalAppleEmail = UserDefaults.standard.string(forKey: "userEmail") ?? ""
                
            }
            
            self.saveUserInKeychain(userIdentifier)
            
            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
            self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email, token: token)
            
        case let passwordCredential as ASPasswordCredential:
            
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                self.showPasswordCredentialAlert(username: username, password: password)
            }
            
        default:
            break
        }
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.imoves.rplus.rplusapp", account: "userIdentifier").saveItem(userIdentifier)
            print("save it ")
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
    
    private func showResultViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?, token: String?) {
        
        UserDefaults.standard.setValue("\(token ?? "")", forKey: "Apple_Token")
        
        //Calling REgisterViewController
        self.loginRplusViewModel.requestLoginRplus(body: ["\(GlobalParameters.instance().globalAppleEmail )", "\(userIdentifier)", "2","\(userIdentifier)", "\(token ?? "")", "", "", "", ""])
        
        print("Apple \(userIdentifier) -  \(String(describing: fullName?.familyName)) -  \(String(describing: email)) -  \(String(describing: token)) ")
        
    }
    
    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// - Tag: did_complete_error
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        
        print("ERROR --> \(error.localizedDescription)")
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        print("open window")
        return self.view.window!
    }
}

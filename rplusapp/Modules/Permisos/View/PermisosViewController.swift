//
//  PermisosViewController.swift
//  rplusapp
//
//  Created by Josué López on 12/8/20.
//

import UIKit

class PermisosViewController: UIViewController {
    
    @IBOutlet weak var btnSave: UIButton!
    
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
        
    }
    
    @IBAction func actionSave(_ sender: UIButton) {
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

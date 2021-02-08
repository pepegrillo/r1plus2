//
//  ResidencialViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/17/20.
//

import UIKit
import SDWebImage

class ResidencialViewController: UIViewController {
    
    @IBOutlet weak var cvResidencial: UICollectionView!
    
    private var residencialViewModel = ResidencialViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
        
    }
    
    @IBAction func actionCerrar(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension ResidencialViewController {
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // Tableview Set DataSource and DataDelegate
        cvResidencial.dataSource = self
        cvResidencial.delegate = self
        
        // Call pageSetup
        pageSetup()
    }
    
    // Initial page setup
    private func pageSetup()  {
        // Calling from viewmodel class
        residencialViewModel.requestGetResidencial()
        closureSetUp()
    }
    
    // Closure initialize
    func closureSetUp()  {
        residencialViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.cvResidencial.reloadData()
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
            
        }
        residencialViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                
                self?.cvResidencial.isHidden = true
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
        }
    }
}

extension ResidencialViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tap")
        let data = residencialViewModel.listArray[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "TipoResidenteViewController") as! TipoResidenteViewController
        vc.paramIdResidencia = data.id ?? 0
        self.present(vc, animated: true)
    }
}

extension ResidencialViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return residencialViewModel.listArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvResidencial.dequeueReusableCell(withReuseIdentifier: "ResidencialCell", for: indexPath as IndexPath) as! ResidencialCollectionViewCell
        
        let data = residencialViewModel.listArray[indexPath.row]
        
        cell.containerButton.cornerRadiusViewBorder(bcColor: .white, borderRadius: Constants.App.cornerRadiusView)
        
        cell.imageLogo.sd_setImage(with: URL(string: "\(data.logo ?? "")"), placeholderImage: UIImage(named: "AddCasaIcon"))
        cell.lblTitle?.text = data.name
        
        return cell
    }
}

extension ResidencialViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        // 60 padding, 20 space between cells
        return CGSize(width: (UIScreen.main.bounds.width - (60+20))/2, height: 235)
        
        
    }
}

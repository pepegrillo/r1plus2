//
//  ReportesViewController.swift
//  rplusapp
//
//  Created by Josué López on 11/10/20.
//

import UIKit
import SDWebImage
import SDWebImageSVGKitPlugin

class ReportesViewController: UIViewController {
    
    // MARK: - Navigation item Historial reporte & Notificaciones
    @IBOutlet weak var btnHistorialReporte: UIButton!
    @IBOutlet weak var btnNotificaciones: UIButton!
    
    // MARK: - Alertas Parameters
    @IBOutlet weak var cvAlerta: UICollectionView!
    
    private var directorioViewModel = DirectorioViewModel()
    
    
    // MARK: - Reportes Parameters
    @IBOutlet weak var cvReporte: UICollectionView!
    
    private var reporteViewModel = ReporteViewModel()
    
    var imageView: SVGKImageView! // can be either `SVGKLayeredImageView` or `SVGKFastImageView`
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.visibleViewController?.title = "Reportes"
        
        // show buttons in bar navigation
        setBarButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init loading
        initialMethod()
        
        // init setScreenDesign
        setScreenDesign()
        
    }
    
    @IBAction func actionHistorialReportes(_ sender: UIButton) {
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "MisReportesViewController") as! MisReportesViewController
        navigationController?.pushViewController(vc, animated: true)
    
    }
}

extension ReportesViewController {
    
    private func setScreenDesign() {
        
        btnHistorialReporte.imageView?.contentMode = .scaleAspectFit
        btnNotificaciones.imageView?.contentMode = .scaleAspectFit
    }
    
    private func setBarButton(){
        
        btnNotificaciones.imageView?.contentMode = .scaleAspectFit
        let barButton = UIBarButtonItem(customView: btnNotificaciones)
        
        btnHistorialReporte.imageView?.contentMode = .scaleAspectFit
        let barButton2 = UIBarButtonItem(customView: btnHistorialReporte)
        self.navigationController?.visibleViewController?.navigationItem.rightBarButtonItems = [barButton, barButton2]
    }
    
    private func initialMethod() {
        
        // init loading
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
        
        // Tableview Set DataSource and DataDelegate
        // MARK: - Alertas Parameters
        cvAlerta.dataSource = self
        cvAlerta.delegate = self
        
        // MARK: - Reporte Parameters
        cvReporte.dataSource = self
        cvReporte.delegate = self
        
        // Call pageSetup
        pageSetup()
    }
    
    // Initial page setup
    private func pageSetup()  {
        // Calling from viewmodel class
        directorioViewModel.requestGetDirectorio()
        reporteViewModel.requestGetReporte()
        closureSetUp()
    }
    
    // Closure initialize
    func closureSetUp()  {
        directorioViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.cvAlerta.reloadData()
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
            
        }
        directorioViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                
                self?.cvAlerta.isHidden = true
                ActivityIndicator.sharedIndicator.hideActivityIndicator()
            }
        }
        
        // proveedor
        reporteViewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.cvReporte.reloadData()
            }
            
        }
        reporteViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                
                self?.cvReporte.isHidden = true
                
            }
        }
    }
}

extension ReportesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView == self.cvAlerta) {
            
            let data = directorioViewModel.listArrayEmergencia[indexPath.row]
            
            if let url = URL(string: "tel://\(data.phone ?? "")") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        } else {
            print("cvReporte")
            let data = reporteViewModel.listArray[indexPath.row]
            
            let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "ReporteRegistroViewController") as! ReporteRegistroViewController
            vc.paramId = data.id
            vc.paramTitle = data.name
            vc.paramSubtitle = data.name
            vc.paramImgReporte = data.imgAlerta
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

extension ReportesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == self.cvAlerta) {
            return directorioViewModel.listArrayEmergencia.count
        } else {
            return reporteViewModel.listArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.cvAlerta) {
            
            let cell = cvAlerta.dequeueReusableCell(withReuseIdentifier: "AlertaCell", for: indexPath as IndexPath) as! AlertaCollectionViewCell
            
            let data = directorioViewModel.listArrayEmergencia[indexPath.row]
            
            cell.imageIcon.sd_setImage(with: URL(string: "\(data.photo ?? "")"))
            cell.lblTitle?.text = data.name?.capitalized
            
            return cell
            
        } else {
            
            let cell = cvReporte.dequeueReusableCell(withReuseIdentifier: "ReporteCell", for: indexPath as IndexPath) as! ReporteCollectionViewCell
            
            let data = reporteViewModel.listArray[indexPath.row]
            
//            cell.container.cornerRadiusView(borderRadius: Constants.App.cornerRadiusView)
            cell.contentView.cornerRadiusShadowView()
            
            let svgCoder = SDImageSVGKCoder.shared
            SDImageCodersManager.shared.addCoder(svgCoder)
            
            
            cell.imageIcon.backgroundColor = .clear
            cell.imageIcon.tintColor = .clear
            cell.imageIcon.sd_setImage(with: URL(string: "\(data.imgAlerta ?? "")"))
            
            cell.lblTitle?.text = data.name?.capitalized
            
            return cell
        }
        
        
    }
}

extension ReportesViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == self.cvAlerta) {
            // 60 padding, 20 space between cells
            return CGSize(width: (UIScreen.main.bounds.width - (10+10))/5, height: 108)
        } else {
            // 60 padding, 20 space between cells
            return CGSize(width: (UIScreen.main.bounds.width - (60+20))/3, height: 145)
        }
        
    }
}


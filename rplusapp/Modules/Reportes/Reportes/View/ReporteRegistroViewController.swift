//
//  ReporteRegistroViewController.swift
//  rplusapp
//
//  Created by Josué López on 12/2/20.
//

import UIKit

class ReporteRegistroViewController: UIViewController {
    
    // MARK: - Registro Reportes Outlets
    @IBOutlet weak var containerForm1: UIView!
    @IBOutlet weak var imgReporteDetail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var txtDescripcion: UITextView!
    
    @IBOutlet weak var containerForm2: UIView!
    @IBOutlet weak var imgReporte1: UIImageView!
    @IBOutlet weak var btnImgReporte1: UIButton!
    @IBOutlet weak var imgReporte2: UIImageView!
    @IBOutlet weak var btnImgReporte2: UIButton!
    @IBOutlet weak var imgReporte3: UIImageView!
    @IBOutlet weak var btnImgReporte3: UIButton!
    @IBOutlet weak var imgReporte4: UIImageView!
    @IBOutlet weak var btnImgReporte4: UIButton!
    @IBOutlet weak var imgReporte5: UIImageView!
    @IBOutlet weak var btnImgReporte5: UIButton!
    
    @IBOutlet weak var btnRegisterReporte: UIButton!
    
    // var fill data
    var paramId: Int?
    var paramTitle, paramSubtitle, paramImgReporte: String?
    
    //picker select image
    var imagePicker: ImagePicker!
    var imageDataReporte1 = ""
    var imageDataReporte2 = ""
    var imageDataReporte3 = ""
    var imageDataReporte4 = ""
    var imageDataReporte5 = ""
    var tagSelected = 0
    
    // register reporte
    private var registroReporteViewModel: RegistroReporteViewModel {
        RegistroReporteViewModel(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set design
        setScreenDesign()
        
        //fill daata
        fillData()
    }
    
    @IBAction func actionRegistroReporte(_ sender: Any) {
        
        // validate data
        validate()
    }
    
    @IBAction func actionPickerImage1(_ sender: UIButton) {
        tagSelected = sender.tag
        self.imagePicker.present(from: sender)
    }
    @IBAction func actionPickerImage2(_ sender: UIButton) {
        tagSelected = sender.tag
        self.imagePicker.present(from: sender)
    }
    @IBAction func actionPickerImage3(_ sender: UIButton) {
        tagSelected = sender.tag
        self.imagePicker.present(from: sender)
    }
    @IBAction func actionPickerImage4(_ sender: UIButton) {
        tagSelected = sender.tag
        self.imagePicker.present(from: sender)
    }
    @IBAction func actionPickerImage5(_ sender: UIButton) {
        tagSelected = sender.tag
        self.imagePicker.present(from: sender)
    }
}

extension ReporteRegistroViewController {
    
    //set design
    private func setScreenDesign() {
        
        containerForm1.cornerRadiusViewBorder(bcColor: Constants.PaletteColors.aLightGray, borderRadius: Constants.App.cornerRadius)
        containerForm2.cornerRadiusViewBorder(bcColor: Constants.PaletteColors.aLightGray, borderRadius: Constants.App.cornerRadius)
        
        //delegate to UIPickerImage
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        self.btnRegisterReporte.cornerButton(borderRadius: Constants.App.cornerRadiusButton)
    }
    
    private func fillData(){
        
        lblTitle.text = paramTitle
        lblSubtitle.text = paramSubtitle
        imgReporteDetail.sd_setImage(with: URL(string: paramImgReporte ?? ""), placeholderImage: UIImage(named: Constants.App.imagePlaceholder))
    }
    
    //validate form
    private func validate() {
        
        
        guard (txtDescripcion.text != "") else {
            AlertManager.showAlert(withMessage: "Descripcion es campo obligatorio", title: "Advertencia")
            return
        }
        
        guard (imageDataReporte1 != "") else {
            AlertManager.showAlert(withMessage: "Ingresar al menos una fotografia", title: "Advertencia")
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
                            
            var arrImagesSelected: [String] = .init()
            
            if (self.imageDataReporte1 != "") {
                
                arrImagesSelected.append(self.imageDataReporte1 )
                
            }
            if (self.imageDataReporte2 != "") {
                arrImagesSelected.append(self.imageDataReporte2 )
                
            }
            if (self.imageDataReporte3 != "") {
                arrImagesSelected.append(self.imageDataReporte3 )
                
            }
            if (self.imageDataReporte4 != "") {
                arrImagesSelected.append(self.imageDataReporte4 )
            
            }
            if (self.imageDataReporte5 != "") {
                arrImagesSelected.append(self.imageDataReporte5 )
            }
             
            
//            print(["\(self.paramId ?? 0)", "\(self.txtDescripcion.text ?? "")","17.98989898", "-89.00889988","\(arrImagesSelected )"])
            
            self.registroReporteViewModel.requestRegistroReporte(body: ["\(self.paramId ?? 0)", "\(self.txtDescripcion.text ?? "")","17.98989898", "-89.00889988"], arrImages: arrImagesSelected)
            group.leave()
        }
        
        group.notify(queue: .main) {
            // Alert
            print("------- 3 notify")
        }
        
    }
    
}

extension ReporteRegistroViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        
        guard let image = image else {
            return
        }
        
        if (tagSelected == 1) {
            
            self.imgReporte1.image = image
            self.imgReporte1.makeRounded()
            let imageQualityAvatar:NSData = (imgReporte1.image?.jpegData(compressionQuality: 0))! as NSData
            imageDataReporte1 = "data:image/jpeg;base64," + imageQualityAvatar.base64EncodedString(options: .lineLength64Characters)
            
        } else if (tagSelected == 2) {
            
            self.imgReporte2.image = image
            self.imgReporte2.makeRounded()
            let imageQualityAvatar:NSData = (imgReporte1.image?.jpegData(compressionQuality: 0))! as NSData
            imageDataReporte2 = "data:image/jpeg;base64," + imageQualityAvatar.base64EncodedString(options: .lineLength64Characters)
            
        } else if (tagSelected == 3) {
            
            self.imgReporte3.image = image
            self.imgReporte3.makeRounded()
            let imageQualityAvatar:NSData = (imgReporte3.image?.jpegData(compressionQuality: 0))! as NSData
            imageDataReporte3 = "data:image/jpeg;base64," + imageQualityAvatar.base64EncodedString(options: .lineLength64Characters)
            
        } else if (tagSelected == 4) {
            
            self.imgReporte4.image = image
            self.imgReporte4.makeRounded()
            let imageQualityAvatar:NSData = (imgReporte4.image?.jpegData(compressionQuality: 0))! as NSData
            imageDataReporte4 = "data:image/jpeg;base64," + imageQualityAvatar.base64EncodedString(options: .lineLength64Characters)
            
        } else {
            
            self.imgReporte5.image = image
            self.imgReporte5.makeRounded()
            let imageQualityAvatar:NSData = (imgReporte5.image?.jpegData(compressionQuality: 0))! as NSData
            imageDataReporte5 = "data:image/jpeg;base64," + imageQualityAvatar.base64EncodedString(options: .lineLength64Characters)
        }
    }
}

extension ReporteRegistroViewController: RegistroReporteDelegate {
    func registroReporteCompleted() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: "Registro exitoso", title: "Mensaje")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func registroReporteCompleted(with error: String) {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            AlertManager.showAlert(withMessage: error, title: "Error")
            
        }
    }
    
}

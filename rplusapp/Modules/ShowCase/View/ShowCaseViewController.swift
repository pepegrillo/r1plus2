//
//  ShowCaseViewController.swift
//  rplusapp
//
//  Created by Josué López on 12/7/20.
//

import UIKit

class ShowCaseViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageBgShowcase: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnSkip: UIButton!
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    //data for the slides
    var titles = ["Bienvenido a R Plus","Reporta tus visitas","Multiples secciones"]
    var descs = ["Una herramienta innovadora que le ayudará a agilizar los procesos de comunicación entre los administradores de su residencia y mantenerse informado sobre actividades y servicios que recibe.","Ahora con facilidad podrás reportar tus visitas frecuentes y eventuales así también empleados y proveedores, a quienes podrás compartir un código QR que facilitará y agilizará el proceso de verificación al ingreso y salidas de una manera segura.","R plus se convierte en una herramienta dinámica, que te facilitará lo siguiente: \n   - Reportar incidencias \n - Solicitar reservación de áreas comunes para tus eventos. \n - Registrar a tu mascota. \n - Ver anuncios y actividades. \n - Contactar vía telefónica en caso de emergencia."]
    var imgs = ["showcase1","showcase2","showcase3"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //get dynamic width and height of scrollview and save it
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set only shows once
        AppData.sharedData.saveShowcase()
        
        self.view.layoutIfNeeded()
        //to call viewDidLayoutSubviews() and get dynamic width and height of scrollview
        
        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        //crete the slides and add them
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
        for index in 0..<titles.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)
            
            let slide = UIView(frame: frame)
            
            //subviews
            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
            imageView.frame = CGRect(x:0,y:0,width:250,height:250)
            imageView.contentMode = .scaleAspectFit
            imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 125)
            
            let txt1 = UILabel.init(frame: CGRect(x:32,y:imageView.frame.maxY+30,width:scrollWidth-64,height:30))
            txt1.textAlignment = .center
            txt1.font = UIFont.boldSystemFont(ofSize: 20.0)
            txt1.text = titles[index]
            txt1.textColor = UIColor(cgColor: Constants.PaletteColors.colorFourth.cgColor)
            
            let txt2 = UILabel.init(frame: CGRect(x:32,y:txt1.frame.maxY+10, width: scrollWidth-64, height: 210))
            txt2.textAlignment = .left
            txt2.numberOfLines = 15
            txt2.font = UIFont.systemFont(ofSize: 16.0)
            txt2.text = descs[index]
            txt2.textColor = UIColor(cgColor: Constants.PaletteColors.colorFourth.cgColor)
            
            slide.addSubview(imageView)
            slide.addSubview(txt1)
            slide.addSubview(txt2)
            scrollView.addSubview(slide)
            
            
        }
        
        //set width of scrollview to accomodate all the slides
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)
        
        //disable vertical scroll/bounce
        self.scrollView.contentSize.height = 1.0
        
        //initial state
        pageControl.numberOfPages = titles.count
        pageControl.currentPage = 0
    }
    
    //indicator
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }
    
    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
        print(page)
        //background showcase
//        imageBgShowcase.image = UIImage(named: "BgShowcase\(Int(page)+1)")
        
        UIView.transition(with: imageBgShowcase,
                          duration: 0.75,
                          options: .transitionCrossDissolve,
                          animations: { self.imageBgShowcase.image = UIImage(named: "BgShowcase\(Int(page)+1)") },
                          completion: nil)
        
    }
    
    // MARK: action btn Omitir
    
    @IBAction func actionSkip(_ sender: UIButton) {
//        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "PermisosViewController") as! PermisosViewController
//        navigationController?.pushViewController(vc, animated: true)
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}


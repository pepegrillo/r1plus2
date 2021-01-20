//
//  GeneralWebviewViewController.swift
//  rplusapp
//
//  Created by Josué López on 12/7/20.
//

import WebKit

class GeneralWebviewViewController: UIViewController,
    WKNavigationDelegate {
    
    var webViewGeneric: WKWebView!
    
    var strTitle: String?
    var strURL: String?
    
    override func loadView() {
        webViewGeneric = WKWebView()
        webViewGeneric.navigationDelegate = self
        view = webViewGeneric
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(strTitle ?? "RPlus")"
        let url = URL(string: strURL ?? "http://www.i-moves.com/")!
        webViewGeneric.load(URLRequest(url: url))
        webViewGeneric.allowsBackForwardNavigationGestures = true
        
    }
    
}

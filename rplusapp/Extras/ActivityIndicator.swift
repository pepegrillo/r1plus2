//
//  ActivityIndicator.swift
//  TributaSV
//
//  Created by Josué López on 11/9/20.
//  Copyright © 2020 Josué López. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ActivityIndicator {
    
    static let sharedIndicator = ActivityIndicator()
    private var spinnerView = UIView()

    func displayActivityIndicator(onView : UIView) {
        spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.25)
        let ai = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), type: .ballScaleMultiple, color: Constants.PaletteColors.aBlue, padding: 10)
        ai.startAnimating()
        ai.center = spinnerView.center
            
        DispatchQueue.main.async { [weak self] in
            guard let _self = self else { return }
            _self.spinnerView.addSubview(ai)
            onView.addSubview(_self.spinnerView)
        }
    }

    func hideActivityIndicator() {
       DispatchQueue.main.async {[weak self] in
           guard let _self = self else { return }
           _self.spinnerView.removeFromSuperview()
       }
    }
}

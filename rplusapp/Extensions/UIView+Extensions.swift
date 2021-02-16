//
//  UIView+Extensions.swift
//  rplusapp
//
//  Created by Josué López on 11/17/20.
//

import UIKit

extension UIView {
    
    func cornerRadiusShadowView(){
        layer.borderWidth = 0.25
        layer.borderColor = Constants.PaletteColors.aBorderGray.cgColor
        layer.cornerRadius = Constants.App.cornerRadiusButton
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 3
        layer.masksToBounds = true

    }
    
    func cornerRadiusView(borderRadius: CGFloat){
        layer.cornerRadius = borderRadius
        layer.masksToBounds = true
    }
    
    func cornerRadiusViewBorder(bcColor: UIColor, borderRadius: CGFloat){
        
        backgroundColor = bcColor
        layer.borderWidth = 0.75
        layer.borderColor = Constants.PaletteColors.rBorderForm.cgColor
        layer.cornerRadius = borderRadius
        layer.masksToBounds = true
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
    
    func cardView(bcColor: UIColor){
        
        backgroundColor = bcColor
        layer.cornerRadius = Constants.App.cornerRadiusView
        layer.shadowColor = Constants.PaletteColors.aGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = Constants.App.cornerRadiusView / 2
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 15, y: self.frame.size.height - width, width: self.frame.size.width - 30, height: width)
        self.layer.addSublayer(border)
    }
}

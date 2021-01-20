//
//  TextFields.swift
//  rplusapp
//
//  Created by Josué López on 11/9/20.
//  Copyright © 2020 Josué López. All rights reserved.
//

import UIKit

extension UITextField {
    
    func searchRoundedTxt(borderRadius: CGFloat){
        layer.cornerRadius = borderRadius
        layer.borderWidth = 1
        layer.backgroundColor = UIColor.white.cgColor
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        layer.masksToBounds = true
    }
    
    func aDefaultTxt(placeHolder: String? = "", bcColor: UIColor? = .white) {
        customTxt(bcColor: bcColor, placeholderText:placeHolder)
        keyboardType = UIKeyboardType.default
    }
    
    func aNumberTxt(placeHolder:String? = "", bcColor: UIColor? = .white) {
        customTxt(bcColor: bcColor, placeholderText:placeHolder)
        keyboardType = UIKeyboardType.numberPad
    }
    
    func aDecimalTxt(placeHolder:String? = "", bcColor: UIColor? = .white) {
        customTxt(bcColor: bcColor, placeholderText:placeHolder)
        keyboardType = UIKeyboardType.decimalPad
    }
    
    func aPhoneTxt(placeHolder:String? = "", bcColor: UIColor? = .white) {
        customTxt(bcColor: bcColor, placeholderText:placeHolder)
        keyboardType = UIKeyboardType.phonePad
    }
    
    func aEmailTxt(placeHolder:String? = "", bcColor: UIColor? = .white) {
        customTxt(bcColor: bcColor, placeholderText:placeHolder)
        keyboardType = UIKeyboardType.emailAddress
    }
    
    func aPasswordTxt(placeHolder:String? = "", bcColor: UIColor? = .white) {
        customTxt(bcColor: bcColor, placeholderText:placeHolder,secure:true)
    }
    
    private func customTxt(bcColor:UIColor? = .white, titleColor:UIColor? = Constants.PaletteColors.aGray, borderColor:UIColor? = .clear, placeholderText:String? = "", secure:Bool? = false) {
        textColor = titleColor
        backgroundColor = bcColor
        isSecureTextEntry = secure!
        attributedPlaceholder = NSAttributedString(string: placeholderText!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)])
        layer.cornerRadius = CGFloat(2.0)
        layer.masksToBounds = true
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = CGFloat(0)
        renderLine()
    }
    
    private func renderLine() {
        self.borderStyle = .none
        //self.layer.backgroundColor = UIColor.white.cgColor

        self.layer.masksToBounds = false
        self.layer.shadowColor = Constants.PaletteColors.rBorderForm.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
    }
    
    // Validator.swift
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
}

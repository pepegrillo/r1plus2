//
//  Buttons.swift
//  rplusapp
//
//  Created by Josué López on 11/9/20.
//  Copyright © 2020 Josué López. All rights reserved.
//

import UIKit

extension UIButton {

    
    
    func centerVerticallyWithPadding(padding : CGFloat = 6.0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
            return
        }
        
        titleLabel?.textAlignment = .center

        let totalHeight = imageViewSize.height + titleLabelSize.height + padding

        self.imageEdgeInsets = UIEdgeInsets(
            top: max(0, -(totalHeight - imageViewSize.height)),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )

        self.titleEdgeInsets = UIEdgeInsets(
            top: (totalHeight - imageViewSize.height),
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )

        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
    
    func customButton(bcColor: UIColor, borderRadius: CGFloat){
        layer.borderWidth = 0.75
        layer.borderColor = Constants.PaletteColors.rBorderForm.cgColor
        backgroundColor = bcColor
        layer.cornerRadius = borderRadius
        layer.masksToBounds = true
    }
    
    func cornerButton(borderRadius: CGFloat){
        layer.borderWidth = 0.75
        layer.borderColor = Constants.PaletteColors.rButtonBg.cgColor
        layer.cornerRadius = borderRadius
        layer.masksToBounds = true
    }
    
}

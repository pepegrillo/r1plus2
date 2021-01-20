//
//  Cells+Extensions.swift
//  rplusapp
//
//  Created by Josué López on 11/9/20.
//  Copyright © 2020 Josué López. All rights reserved.
//

import UIKit

open class ReusableTableViewCell: UITableViewCell {
    
    // Reuse Identifier String
    public class var reuseIdentifier: String {
        return "\(self.self)"
    }
    
    // Registers the Nib with the provided table
    public static func registerWithTable(_ table: UITableView) {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: self.reuseIdentifier , bundle: bundle)
        table.register(nib, forCellReuseIdentifier: self.reuseIdentifier)
    }
}

open class ReusableCollectionViewCell: UICollectionViewCell {
    
    // Reuse Identifier String
    public class var reuseIdentifier: String {
        return "\(self.self)"
    }
    
    // Registers the Nib with the provided table
    public static func registerWithCollectionView(_ collectionView: UICollectionView) {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: self.reuseIdentifier , bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: self.reuseIdentifier)
    }
}


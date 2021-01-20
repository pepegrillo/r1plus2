//
//  Collection+Extensions.swift
//  rplusapp
//
//  Created by Josué López on 11/24/20.
//

import UIKit

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}

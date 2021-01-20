//
//  NotifyManager.swift
//  rplusapp
//
//  Created by Josué López on 11/9/20.
//  Copyright © 2020 Josué López. All rights reserved.
//

import Foundation
import UIKit

//Adjusts UITableView content height when keyboard show/hide
public protocol KeyboardObservable: NSObjectProtocol {
    func registerForKeyboardEvents()
    func unregisterForKeyboardEvents()
}

extension KeyboardObservable where Self: UIViewController {

    public func registerForKeyboardEvents() {
        let defaultCenter = NotificationCenter.default
        
        var tokenShow: NSObjectProtocol!
        tokenShow = defaultCenter.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: nil) { [weak self] (notification) in
                    guard self != nil else {
                        defaultCenter.removeObserver(tokenShow as Any)
                        return
                    }
            self!.keyboardDidShow((notification as NSNotification) as Notification)
                }
        
//        NotificationCenter.default.addObserver(self, selector: #selector(.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(.keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
//        navigationController?.navigationBar.isHidden = true

//        var tokenShow: NSObjectProtocol!
//        tokenShow = defaultCenter.addObserver(forName: .UIKeyboardDidShow, object: nil, queue: nil) { [weak self] (notification) in
//            guard self != nil else {
//                defaultCenter.removeObserver(tokenShow)
//                return
//            }
//            self!.keyboardWilShow(notification as NSNotification)
//        }
//
        var tokenHide: NSObjectProtocol!
        tokenHide = defaultCenter.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] (notification) in
            guard self != nil else {
                defaultCenter.removeObserver(tokenHide as Any)
                return
            }
            self!.keyboardWillHide((notification as NSNotification) as Notification)
        }
        
        navigationController?.navigationBar.isHidden = true
    }

    private func keyboardDidShow(_ notification: Notification) {
        var keyboardFrame:CGRect = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        guard view.frame.origin.y == 0 else { return }
        view.frame.origin.y = -keyboardFrame.height * 0.5
    }

    private func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }

   

}

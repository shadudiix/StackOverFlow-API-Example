//
//  Extensions.swift
//  StackOverflow
//
//  Created by Shady K. Maadawy on 10/07/2022.
//

import UIKit
 
extension UISearchBar {
    
    func DisableUserInteraction() {
        self.isUserInteractionEnabled = false
    }
    
    func EnableUserInteraction() {
        self.isUserInteractionEnabled = true
    }
    
}

extension UIView {
    
    func Show() {
        self.isHidden = false
        // check if the current Ui Element is an Indicator, if it is, let's animate it.
        if self is UIActivityIndicatorView {
            let Indicator = self as! UIActivityIndicatorView // casting as UIActivityIndicatorView to access animating function
            Indicator.startAnimating()
        }
    }
    
    func Hide() {
        self.isHidden = true
        if self is UIActivityIndicatorView {
            let Indicator = self as! UIActivityIndicatorView
            Indicator.stopAnimating()
        }
    }
    
}

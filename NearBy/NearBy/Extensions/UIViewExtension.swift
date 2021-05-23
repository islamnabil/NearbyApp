//
//  UIViewExtension.swift
//  Forkify
//
//  Created by Islam Elgaafary on 21/05/2021.
//

import UIKit

extension UIView {
    /// Find the ViewController for a UIView
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

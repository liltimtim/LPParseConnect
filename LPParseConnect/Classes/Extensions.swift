//
//  Extensions.swift
//  Pods
//
//  Created by Timothy Dillman on 7/24/17.
//
//

import Foundation
import UIKit
public extension UIViewController {
    public static func loadFromXIB<T: UIViewController>(type: T.Type) -> T {
        return type.init(nibName: String(describing: T.self), bundle: Bundle.init(for: T.self))
    }
}

public extension UITextField {
    func invalidate() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.red.cgColor
    }
}

public extension UIAlertController {
    public static func createErrorAlert(title:String, message:String, okayActionTitle:String) -> UIAlertController {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: okayActionTitle, style: .default, handler: nil)
        alert.addAction(okayAction)
        return alert
    }
    
    public static func createErrorAlert(title:String, error:Error, okayActionTitle:String) -> UIAlertController {
        return createErrorAlert(title: title, message: error.localizedDescription, okayActionTitle: okayActionTitle)
    }
    
    public static func createErrorAlert(error: Error) -> UIAlertController {
        return createErrorAlert(title: "Oops", error: error, okayActionTitle: "Okay")
    }
}

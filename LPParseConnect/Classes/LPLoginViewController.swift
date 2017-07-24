//
//  LoginViewController.swift
//  Pods
//
//  Created by Timothy Dillman on 7/24/17.
//
//

import UIKit
import SwiftValidator
public protocol LPLoginViewControllerProtocol: class {
    func didFinishAuthenticating()
}
open class LPLoginViewController: UIViewController, LPAuthEmittableProtocol {
    @IBOutlet public weak var usernameField:UITextField!
    @IBOutlet public weak var passwordField:UITextField!
    @IBOutlet public weak var loginBtn:UIButton_LPActivity!
    public weak var delegate:LPLoginViewControllerProtocol?
    internal var validator:Validator = Validator()
    internal var provider:StandardAuthProvider?
    override open func viewDidLoad() {
        super.viewDidLoad()
        validator.registerField(usernameField, rules: [RequiredRule(), EmailRule()])
        validator.registerField(passwordField, rules: [RequiredRule()])
        setupFields()
        loginBtn.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func loginPressed() {
        loginBtn.beginActivity()
        validator.validate(self)
    }
    
    internal func login(username:String, password:String) {
        provider = StandardAuthProvider.init(delegate: self)
        provider?.authenticate(username: username, password: password)
    }
    
    public func didEmit(error: Error) {
        loginBtn.endActivity()
        self.present(UIAlertController.createErrorAlert(error: error), animated: true, completion: nil)
    }
    
    public func didAuthenticate() {
        loginBtn.endActivity()
        self.delegate?.didFinishAuthenticating()
    }
    
    open func setupFields() {
        usernameField.autocorrectionType = .no
        usernameField.autocapitalizationType = .none
        passwordField.isSecureTextEntry = true
    }
}

extension LPLoginViewController : ValidationDelegate {
    public func validationSuccessful() {
        self.login(username: usernameField.text!, password: passwordField.text!)
    }
    
    public func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        loginBtn.endActivity()
        for(item, _) in errors {
            if let field = item as? UITextField {
                field.invalidate()
            }
        }
    }
}



//
//  LoginViewController.swift
//  Pods
//
//  Created by Timothy Dillman on 7/24/17.
//
//

import UIKit
import SwiftValidator
import LPCommonUI
public protocol LPLoginViewControllerProtocol: class {
    func didFinishAuthenticating()
}
open class LPLoginViewController: UIViewController, LPAuthEmittableProtocol, ValidationDelegate {
    @IBOutlet public weak var usernameField:UITextField!
    @IBOutlet public weak var passwordField:UITextField!
    @IBOutlet public weak var loginBtn:UIButton_LPActivity!
    public weak var delegate:LPLoginViewControllerProtocol?
    open var validator:Validator = Validator()
    open var provider:StandardAuthProvider?
    override open func viewDidLoad() {
        super.viewDidLoad()
        validator.registerField(usernameField, rules: [RequiredRule()])
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
    
    open func didAuthenticate() {
        loginBtn.endActivity()
        self.delegate?.didFinishAuthenticating()
    }
    
    open func setupFields() {
        usernameField.autocorrectionType = .no
        usernameField.autocapitalizationType = .none
        passwordField.isSecureTextEntry = true
    }
    
    // MARK: SwiftValidator delegate methods
    
    open func validationSuccessful() {
        self.login(username: usernameField.text!, password: passwordField.text!)
    }
    
    open func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        loginBtn.endActivity()
        for(item, _) in errors {
            if let field = item as? UITextField {
                field.invalidate()
            }
        }
    }
}




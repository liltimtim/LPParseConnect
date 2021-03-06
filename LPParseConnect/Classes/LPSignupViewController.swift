//
//  LPSignupViewController.swift
//  Pods
//
//  Created by Timothy Dillman on 7/24/17.
//
//

import UIKit
import SwiftValidator
public protocol LPSignupViewControllerProtocol: class {
    func didFinishSignup()
}
open class LPSignupViewController: UIViewController {
    @IBOutlet open weak var usernameField:UITextField!
    @IBOutlet open weak var emailField:UITextField!
    @IBOutlet open weak var passwordField:UITextField!
    @IBOutlet open weak var signupBtn:UIButton_LPActivity!
    open weak var delegate:LPSignupViewControllerProtocol?
    open var provider:StandardAuthProvider?
    open let validator:Validator = Validator()
    override open func viewDidLoad() {
        super.viewDidLoad()
        validator.registerField(usernameField, rules: [RequiredRule()])
        validator.registerField(passwordField, rules: [RequiredRule()])
        validator.registerField(emailField, rules: [RequiredRule(), EmailRule()])
        setupFields()
        signupBtn.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @objc open func signUpPressed() {
        signupBtn.beginActivity()
        validator.validate(self)
    }
    
    open func signup(email:String, username:String, password:String) {
        provider = StandardAuthProvider.init(delegate: self)
        provider?.createUser(username: username, email: email, password: password)
    }
    
    open func setupFields() {
        usernameField.placeholder = "Username"
        usernameField.autocorrectionType = .no
        usernameField.autocapitalizationType = .none
        emailField.placeholder = "user@example.com"
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        passwordField.isSecureTextEntry = true
        passwordField.placeholder = "Password"
    }

}

extension LPSignupViewController : LPAuthEmittableProtocol {
    public func didEmit(error err: Error) {
        signupBtn.endActivity()
        self.present(UIAlertController.createErrorAlert(error: err), animated: true, completion: nil)
    }
    
    public func didAuthenticate() {
        signupBtn.endActivity()
        self.delegate?.didFinishSignup()
    }
}

extension LPSignupViewController : ValidationDelegate {
    open func validationSuccessful() {
        self.signup(email: emailField.text!, username: usernameField.text!, password: passwordField.text!)
    }
    
    open func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        signupBtn.endActivity()
        for(item, _) in errors {
            if let field = item as? UITextField {
                field.invalidate()
            }
        }
    }
}

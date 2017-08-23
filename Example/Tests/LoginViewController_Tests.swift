//
//  LoginViewController_Tests.swift
//  LPParseConnect
//
//  Created by Timothy Dillman on 7/24/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import LPParseConnect
import SwiftValidator
class LoginViewController_Tests: XCTestCase {
    
    func testControllerInit() {
        _ = setupHelper()
        
    }
    
    func testMissingEmailValidationFailure() {
        let vc = setupHelper()
        vc.usernameField.text = nil

    }
    
    internal func setupHelper() -> LPLoginViewController {
        let loginVC = LPLoginViewController()
        loginVC.usernameField = UITextField()
        loginVC.passwordField = UITextField()
        let btn = UIButton_LPActivity()
        loginVC.loginBtn = btn
        _ = loginVC.view
        loginVC.viewDidLoad()
        return loginVC
    }
    
}

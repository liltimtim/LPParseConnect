//
//  SignupViewController.swift
//  LPParseConnect
//
//  Created by Timothy Dillman on 7/24/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import LPParseConnect
class SignupViewController: LPSignupViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.text = "test\(arc4random())@test.com"
        usernameField.text = "test\(arc4random())"
        passwordField.text = "password"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

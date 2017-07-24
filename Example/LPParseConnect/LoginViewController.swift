//
//  LoginViewController.swift
//  LPParseConnect
//
//  Created by Timothy Dillman on 7/24/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import LPParseConnect
class LoginViewController: LPLoginViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setupFields() {
        super.setupFields()
        usernameField.placeholder = "user@email.com"
    }

}

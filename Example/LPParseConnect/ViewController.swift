//
//  ViewController.swift
//  LPParseConnect
//
//  Created by liltimtim on 06/06/2017.
//  Copyright (c) 2017 liltimtim. All rights reserved.
//

import UIKit
import LPParseConnect
import Parse

class ViewController: UIViewController {
    @IBOutlet weak var login:UIButton!
    internal var authProvider:StandardAuthProvider?
    override func viewDidLoad() {
        super.viewDidLoad()
        login.addTarget(self, action: #selector(auth(_:)), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.        
    }
    
    internal func auth(_ sender: UIButton) {
        authProvider = StandardAuthProvider.init(delegate: self)
        authProvider?.createUser(username: "liltimtim", email: "liltimtim@gmail.com", password: "password")
    }

}

extension ViewController : LPAuthEmittableProtocol {
    func didAuthenticate() {
        let pushProvider = LPPushServices(delegate: self)
        pushProvider.registerPushNotifications(options: [.alert, .badge, .sound])
    }
    
    func didEmit(error err: Error) {
        authProvider?.authenticate(username: "liltimtim", password: "password")
    }
    
}

class TestObject : PFObject, PFSubclassing {

    @NSManaged var myName:String?
    
    static func parseClassName() -> String {
        return String(describing: TestObject.self)
    }
}

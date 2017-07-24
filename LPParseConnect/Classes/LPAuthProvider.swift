//
//  LPAuthProvider.swift
//  Pods
//
//  Created by Timothy Dillman on 6/6/17.
//
//

import Foundation
import Parse
@objc public protocol LPAuthProviderProtocol: class {
    weak var delegate:LPAuthEmittableProtocol? { get set }
    
}

@objc public protocol LPAuthEmittableProtocol: class, LPEmittableProtocol {
    @objc optional func didAuthenticate()
    @objc optional func didSignup()
}

open class StandardAuthProvider : LPAuthProviderProtocol {
    
    public var delegate: LPAuthEmittableProtocol?
    
    private init() { }
    
    public init(delegate: LPAuthEmittableProtocol) {
        self.delegate = delegate
    }
    
    open func authenticate(username: String, password: String) {
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if error != nil {
                self.delegate?.didEmit(error: error ?? AuthorizationError.unknown)
                return
            }
            
            // check null user
            guard user != nil else {
                self.delegate?.didEmit(error: AuthorizationError.missingUser)
                return
            }
            
            self.delegate?.didAuthenticate?()
        }
    }
    
    open func createUser(username: String, email: String, password: String) {
        let user = PFUser()
        user.username = username
        user.email = email
        user.password = password
        user.signUpInBackground { (success, error) in
            guard error == nil else {
                self.delegate?.didEmit(error: error ?? AuthorizationError.unknown)
                return
            }
            guard success == true else {
                self.delegate?.didEmit(error: AuthorizationError.unknown)
                return
            }
            self.authenticate(username: username, password: password)
        }
    }
    
}

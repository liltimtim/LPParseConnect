//
//  LPAuthentication_Tests.swift
//  LPParseConnect
//
//  Created by Timothy Dillman on 6/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import LPParseConnect
class LPAuthentication_Tests: XCTestCase {
    
    func testInit() {
        let authProvider = StandardAuthProvider.init(delegate: self)
        XCTAssertNotNil(authProvider.delegate)
    }
    
    func testAuthenticationSuccess() {
        let authProvider = MockStandardAuthProvider.init(delegate: self)
        let _ = expectation(forNotification: "didAuthenticate", object: nil, handler: nil)
        authProvider.authenticate(username: "test", password: "test")
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testAuthenticationFail() {
        let authProvider = MockStandardAuthProvider.init(delegate: self)
        let _ = expectation(forNotification: "didEmitError", object: nil, handler: nil)
        authProvider.shouldAuthSuccess = false
        authProvider.authenticate(username: "test", password: "test")
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}

class MockStandardAuthProvider: StandardAuthProvider {
    var shouldAuthSuccess:Bool = true
    override func authenticate(username: String, password: String) {
        if shouldAuthSuccess {
            self.delegate?.didAuthenticate?()
        } else {
            self.delegate?.didEmit(err: AuthorizationError.unknown)
        }
    }
}

extension LPAuthentication_Tests : LPAuthEmittableProtocol {
    func didEmit(err: Error) {
        NotificationCenter.default.post(name: NSNotification.Name.init("didEmitError"), object: err)
    }
    
    func didAuthenticate() {
        NotificationCenter.default.post(name: NSNotification.Name.init("didAuthenticate"), object: nil)
    }
}

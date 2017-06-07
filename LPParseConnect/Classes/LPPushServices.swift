//
//  LPPushServices.swift
//  Pods
//
//  Created by Timothy Dillman on 6/6/17.
//
//

import Foundation
import UserNotifications
import Parse
open class LPPushServices: NSObject {
    weak var delegate:LPEmittableProtocol?
    @available (iOS 10, *)
    
    public init(delegate: LPEmittableProtocol?) {
        super.init()
        self.delegate = delegate
    }
    
    public func registerPushNotifications(options: UNAuthorizationOptions) {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: options) { (success, error) in
            if error == nil {
                UIApplication.shared.registerForRemoteNotifications()
            } else {
                self.delegate?.didEmit(error: error!)
            }
        }
    }
    
    public static func saveDeviceToken(data:Data?) {
        PFInstallation.current()?.setDeviceTokenFrom(data)
        PFInstallation.current()?.saveInBackground()
    }
}


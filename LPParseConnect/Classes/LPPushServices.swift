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
import LPCommonUI
@available (iOS 10, *)
open class LPPushServices: NSObject {
    weak var delegate:LPEmittableError?
    public init(delegate: LPEmittableError?) {
        super.init()
        self.delegate = delegate
    }
    /**
     Registers for push notification 
     - parameter options: can be a single option or an array of options such as badge, alert or sound
    */
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


//
//  LPConnect.swift
//  Pods
//
//  Created by Timothy Dillman on 6/6/17.
//
//

import Foundation
import Parse

public struct LPConnect {
    /**
     Provides a single entry setup point to kick off your Parse configuration. 
     
     - parameter appId: the application ID used to setup Parse.
     - parameter serverURL: the full server URL including the parse mount point. Example: http://localhost:1337/parse
     - parameter useLocalDatastore: parse comes with the ability to save items locally to the internal on device data store.  You may enable this feature if you wish to save items directly to the device.
     - parameter enableAutomaticUser: PFUser automatic anonymous user ensures PFUser will never be null. The default is true. See reference: http://docs.parseplatform.org/ios/guide/#anonymous-users
    */
    public static func setup(appId: String, serverURL: String, clientKey: String, useLocalDatastore: Bool, enableAutomaticUser: Bool = true) {
        let configuration = ParseClientConfiguration {
            $0.applicationId = appId
            $0.server = serverURL
            $0.clientKey = clientKey
            $0.isLocalDatastoreEnabled = useLocalDatastore
        }
        Parse.initialize(with: configuration)
        if enableAutomaticUser {
            PFUser.enableAutomaticUser()
        }
        
    }
    
}

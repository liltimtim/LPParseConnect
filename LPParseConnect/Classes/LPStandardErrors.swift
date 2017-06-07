//
//  LPStandardErrors.swift
//  Pods
//
//  Created by Timothy Dillman on 6/6/17.
//
//

import Foundation

public enum AuthorizationError: Error, LocalizedError {
    case unknown
    case missingUser
    public var errorDescription: String? {
        switch self {
        case .unknown: return "An unknown error has occurred. Please try again later."
        case .missingUser: return "The user was not returned by the server.  Please try again."
        }
    }
}

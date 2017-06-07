//
//  LPEmittableProtocol.swift
//  Pods
//
//  Created by Timothy Dillman on 6/6/17.
//
//

import Foundation

@objc public protocol LPEmittableProtocol: class {
    func didEmit(error: Error)
}

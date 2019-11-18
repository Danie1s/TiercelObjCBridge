//
//  TRURLConvertible.swift
//  TiercelObjCBridge
//
//  Created by Daniels on 2019/11/18.
//  Copyright © 2019 Daniels. All rights reserved.
//

import Foundation
import Tiercel

@objc public protocol TRURLConvertible {

    func asURL() throws -> URL
}

extension NSString: TRURLConvertible {

    public func asURL() throws -> URL {
        return try (self as String).asURL()
    }
}

extension NSURL: TRURLConvertible {

    public func asURL() throws -> URL { return try (self as URL).asURL() }
}

extension NSURLComponents: TRURLConvertible {

    public func asURL() throws -> URL {
        return try (self as URLComponents).asURL()
    }
}

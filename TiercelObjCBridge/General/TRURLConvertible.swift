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

    func tr_asURL() throws -> URL
}

extension NSString: TRURLConvertible {

    public func tr_asURL() throws -> URL {
        return try self.asURLConvertible().asURL()
    }
    
    internal func asURLConvertible() -> URLConvertible {
        return self as String
    }
}

extension NSURL: TRURLConvertible {

    public func tr_asURL() throws -> URL { return try self.asURLConvertible().asURL() }
    
    internal func asURLConvertible() -> URLConvertible {
        return self as URL
    }
}

extension NSURLComponents: TRURLConvertible {

    public func tr_asURL() throws -> URL {
        return try self.asURLConvertible().asURL()
    }
    
    internal func asURLConvertible() -> URLConvertible {
        return self as URLComponents
    }
}

internal func asURLConvertible(_ url: TRURLConvertible) -> URLConvertible {
    if let temp = url as? NSString {
        return temp as String
    } else if let temp = url as? NSURL {
        return temp as URL
    } else {
        return url as! URLComponents
    }
}

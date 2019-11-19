//
//  TRCommon.swift
//  TiercelObjCBridge
//
//  Created by Daniels Lau on 2019/11/19.
//  Copyright © 2019 Daniels. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import Tiercel

@objc public enum TRStatus: Int {
    case waiting
    case running
    case suspended
    case canceled
    case failed
    case removed
    case succeeded

    case willSuspend
    case willCancel
    case willRemove
    
    internal init(_ status: Status) {
        switch status {
        case .waiting:
            self = .waiting
        case .running:
            self = .running
        case .suspended:
            self = .suspended
        case .canceled:
            self = .canceled
        case .failed:
            self = .failed
        case .removed:
            self = .removed
        case .succeeded:
            self = .succeeded
        case .willSuspend:
            self = .willSuspend
        case .willCancel:
            self = .willCancel
        case .willRemove:
            self = .willRemove

        }
    }
}

@objc public enum TRFileVerificationType : Int {
    case md5
    case sha1
    case sha256
    case sha512
}

@objc public enum TRLogLevel: Int {
    case detailed
    case simple
    case none
}

//
//  TRSessionConfiguration.swift
//  TiercelObjCBridge
//
//  Created by Daniels on 2019/11/16.
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

import UIKit
import Tiercel

@objcMembers public class TRSessionConfiguration: NSObject {
    
    internal var sessionManager: SessionManager?
    
    // 请求超时时间
    public var timeoutIntervalForRequest: TimeInterval = 60.0 {
        didSet {
            sessionManager?.configuration.timeoutIntervalForRequest = timeoutIntervalForRequest
        }
    }

    // 最大并发数
    private var _maxConcurrentTasksLimit: Int = MaxConcurrentTasksLimit {
        didSet {
            sessionManager?.configuration.maxConcurrentTasksLimit = _maxConcurrentTasksLimit
         }
    }
    public var maxConcurrentTasksLimit: Int {
        get {
            return _maxConcurrentTasksLimit
        }
        set {
            if newValue > MaxConcurrentTasksLimit {
                _maxConcurrentTasksLimit = MaxConcurrentTasksLimit
            } else if newValue < 1 {
                _maxConcurrentTasksLimit = 1
            } else {
                _maxConcurrentTasksLimit = newValue
            }
        }
    }

    // 是否允许蜂窝网络下载
    public var allowsCellularAccess: Bool = false {
        didSet {
            sessionManager?.configuration.allowsCellularAccess = allowsCellularAccess
        }
    }

}

var MaxConcurrentTasksLimit: Int {
    if #available(iOS 11.0, *) {
        return 6
    } else {
        return 3
    }
}

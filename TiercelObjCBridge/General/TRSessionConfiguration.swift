//
//  TRSessionConfiguration.swift
//  TiercelObjCBridge
//
//  Created by Daniels on 2019/11/16.
//  Copyright © 2019 Daniels. All rights reserved.
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

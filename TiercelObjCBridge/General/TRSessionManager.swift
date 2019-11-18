//
//  TRSessionManager.swift
//  TiercelObjCBridge
//
//  Created by Daniels on 2019/11/16.
//  Copyright © 2019 Daniels. All rights reserved.
//

import UIKit
import Tiercel

@objcMembers class TRSessionManager: NSObject {

    public var sessionManager: SessionManager
    
    public static var logLevel: LogLevel = .detailed

    public static var isControlNetworkActivityIndicator = true

    public let operationQueue: DispatchQueue
    
    public let cache: Cache
    
    public let identifier: String
    
    public var completionHandler: (() -> Void)? {
        get {
            return sessionManager.completionHandler
        }
        set {
            sessionManager.completionHandler = newValue
        }
    }
    
    
    public var configuration: SessionConfiguration {
        get {
            return sessionManager.configuration
        }
        set {
            sessionManager.configuration = newValue
        }
    }
    
    public var status: Status {
        return sessionManager.status
    }
    
    public var tasks: [DownloadTask] {
        return sessionManager.tasks
    }
    
    
    public var completedTasks: [DownloadTask] {
        return sessionManager.completedTasks
    }
    
    public var progress: Progress {
        return sessionManager.progress
    }
    
    public var speed: Int64 {
        return sessionManager.speed
    }
    
    public var timeRemaining: Int64 {
        return sessionManager.timeRemaining
    }

    @objc(initWithIdentifier:configuration:operationQueue:)
    public init(_ identifier: String,
                            configuration: TRSessionConfiguration,
                            operationQueue: DispatchQueue = DispatchQueue(label: "com.Tiercel.SessionManager.operationQueue")) {

        let config = SessionConfiguration()
        sessionManager = SessionManager.init(identifier, configuration: config, operationQueue: operationQueue)
        self.operationQueue = sessionManager.operationQueue
        cache = sessionManager.cache
        self.identifier = sessionManager.identifier
        super.init()
    }
    
    public func invalidate() {
        sessionManager.invalidate()
    }
    
    

}



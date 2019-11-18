//
//  TRSessionManager.swift
//  TiercelObjCBridge
//
//  Created by Daniels on 2019/11/16.
//  Copyright © 2019 Daniels. All rights reserved.
//

import UIKit
import Tiercel

@objcMembers public class TRSessionManager: NSObject {

    private let sessionManager: SessionManager
    
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


    public convenience init(_ identifier: String,
                            configuration: TRSessionConfiguration) {
        self.init(identifier, configuration: configuration)
    }
    
    public func invalidate() {
        sessionManager.invalidate()

    }

    @discardableResult
    public func download(_ url: TRURLConvertible,
                         headers: [String: String]? = nil,
                         fileName: String? = nil) -> TRDownloadTask? {

        do {
            let validURL = try url.asURL()
            let download = sessionManager.download(validURL, headers: headers, fileName: fileName)
            return nil
        } catch {
            TiercelLog("[manager] url error：\(url)", identifier: identifier)
            return nil
        }
    }

}


extension TRSessionManager {


}

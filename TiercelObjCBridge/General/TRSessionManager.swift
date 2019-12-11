//
//  TRSessionManager.swift
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

@objcMembers public class TRSessionManager: NSObject {

    private let sessionManager: SessionManager
    
    public static var logLevel: TRLogLevel = .detailed {
        didSet {
            switch logLevel {
            case .detailed:
                SessionManager.logLevel = .detailed
            case .simple:
                SessionManager.logLevel = .simple
            case .none:
                SessionManager.logLevel = .none
            }
        }
    }

    public static var isControlNetworkActivityIndicator = true {
        didSet {
            SessionManager.isControlNetworkActivityIndicator = isControlNetworkActivityIndicator
        }
    }

    public let operationQueue: DispatchQueue
    
    public let cache: TRCache
    
    public let identifier: String
    
    public var completionHandler: (() -> Void)? {
        get {
            return sessionManager.completionHandler
        }
        set {
            sessionManager.completionHandler = newValue
        }
    }
    
    
    public var configuration: TRSessionConfiguration {
        didSet {
            configuration.sessionManager = sessionManager
            var config = SessionConfiguration()
            config.timeoutIntervalForRequest = configuration.timeoutIntervalForRequest
            config.maxConcurrentTasksLimit = configuration.maxConcurrentTasksLimit
            config.allowsCellularAccess = configuration.allowsCellularAccess
            sessionManager.configuration = config
        }
    }
    
    public var status: TRStatus {
        return TRStatus(sessionManager.status)
    }
    
    public private(set) var tasks: [TRDownloadTask] = []
    
    
    public var completedTasks: [TRDownloadTask] {
        return tasks.filter { $0.status == .succeeded }
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

    public init(identifier: String,
                            configuration: TRSessionConfiguration,
                            operationQueue: DispatchQueue) {
        self.identifier = identifier
        self.operationQueue = operationQueue
        var config = SessionConfiguration()
        config.timeoutIntervalForRequest = configuration.timeoutIntervalForRequest
        config.maxConcurrentTasksLimit = configuration.maxConcurrentTasksLimit
        config.allowsCellularAccess = configuration.allowsCellularAccess
        self.configuration = configuration
        sessionManager = SessionManager(identifier, configuration: config, operationQueue: operationQueue)
        self.configuration.sessionManager = sessionManager
        cache = TRCache(cache: sessionManager.cache)
        super.init()
        tasks = sessionManager.tasks.map { TRDownloadTask($0) }

    }

    public convenience init(identifier: String,
                            configuration: TRSessionConfiguration) {
        self.init(identifier: identifier, configuration: configuration, operationQueue: DispatchQueue(label: "com.Tiercel.SessionManager.operationQueue"))
    }
    
    public func invalidate() {
        sessionManager.invalidate()
    }

    @discardableResult
    public func download(url: TRURLConvertible,
                         headers: [String: String]?,
                         fileName: String?) -> TRDownloadTask? {
        if let downloadTask = sessionManager.download(asURLConvertible(url), headers: headers, fileName: fileName) {
            let convertDownloadTask = TRDownloadTask(downloadTask)
            tasks.append(convertDownloadTask)
            return convertDownloadTask
        } else {
            return nil
        }

    }
    
    @discardableResult
    public func download(url: TRURLConvertible) -> TRDownloadTask? {
        return download(url: url, headers: nil, fileName: nil)
    }

    
    
    @discardableResult
    public func multiDownload(urls: [TRURLConvertible],
                              headers: [[String: String]]?,
                              fileNames: [String]?) -> [TRDownloadTask] {
        let convertURLs = urls.map { asURLConvertible($0) }
        let downloadTasks = sessionManager.multiDownload(convertURLs, headers: headers, fileNames: fileNames)
        let convertDownloadTasks = downloadTasks.map { TRDownloadTask($0) }
        tasks.append(contentsOf: convertDownloadTasks)
        return convertDownloadTasks
    }
    
    
    @discardableResult
    public func multiDownload(urls: [TRURLConvertible]) -> [TRDownloadTask] {
        return multiDownload(urls: urls, headers: nil, fileNames: nil)
    }
    

    
    
    public func fetchTask(url: TRURLConvertible) -> TRDownloadTask? {
        do {
            let validURL = try url.tr_asURL()
            return tasks.first { $0.url == validURL }
        } catch {
            return nil
        }
    }
    
    public func start(url: TRURLConvertible) {
        sessionManager.start(asURLConvertible(url))
    }
    
    public func start(task: TRDownloadTask) {
        sessionManager.start(task.downloadTask)
    }
    
    public func suspend(url: TRURLConvertible, onMainQueue: Bool, handler: Handler<TRDownloadTask>?) {
        sessionManager.suspend(asURLConvertible(url), onMainQueue: onMainQueue) { [weak self] _ in
            if let task = self?.fetchTask(url: url) {
                handler?(task)
            }
        }
    }
    
    public func suspend(url: TRURLConvertible) {
        suspend(url: url, onMainQueue: true, handler: nil)
    }


    public func cancel(url: TRURLConvertible, onMainQueue: Bool, handler: Handler<TRDownloadTask>?) {
        guard let task = fetchTask(url: url) else { return }
        tasks.removeAll { $0.url == task.url}
        sessionManager.cancel(asURLConvertible(url), onMainQueue: onMainQueue) { [weak self] _ in
            if let task = self?.fetchTask(url: url) {
                handler?(task)
            }
        }
    }
    
    public func cancel(url: TRURLConvertible) {
        cancel(url: url, onMainQueue: true, handler: nil)
    }
    
    public func remove(url: TRURLConvertible, completely: Bool, onMainQueue: Bool, handler: Handler<TRDownloadTask>?) {
        guard let task = fetchTask(url: url) else { return }
        tasks.removeAll { $0.url == task.url}
        sessionManager.remove(asURLConvertible(url), completely: completely, onMainQueue: onMainQueue) { [weak self] _ in
            if let task = self?.fetchTask(url: url) {
                 handler?(task)
             }
        }
    }
    
    public func remove(url: TRURLConvertible) {
        remove(url: url, completely: false, onMainQueue: true, handler: nil)
    }
    
    public func totalStart() {
        self.tasks.forEach { task in
            start(task: task)
        }
    }
    
    public func totalSuspend(onMainQueue: Bool, handler: Handler<TRSessionManager>?) {
        sessionManager.totalSuspend(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler?(self)
        }
    }
    
    public func totalSuspend() {
        totalSuspend(onMainQueue: true, handler: nil)
    }
    
    public func totalCancel(onMainQueue: Bool, handler: Handler<TRSessionManager>?) {
        tasks.removeAll()
        sessionManager.totalCancel(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler?(self)
        }
    }
    
    public func totalCancel() {
        totalCancel(onMainQueue: true, handler: nil)
    }
    
    public func totalRemove(completely: Bool, onMainQueue: Bool, handler: Handler<TRSessionManager>?) {
        tasks.removeAll()
        sessionManager.totalRemove(completely: completely, onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler?(self)
        }
    }
    
    public func totalRemove() {
        totalRemove(completely: false, onMainQueue: true, handler: nil)
    }
    
    @discardableResult
    public func progress(onMainQueue: Bool = true, handler: @escaping Handler<TRSessionManager>) -> Self {
        sessionManager.progress(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler(self)
        }
        return self
    }
    
    @discardableResult
    public func success(onMainQueue: Bool = true, handler: @escaping Handler<TRSessionManager>) -> Self {
        sessionManager.success(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler(self)
        }
        return self
    }
    
    @discardableResult
    public func failure(onMainQueue: Bool = true, handler: @escaping Handler<TRSessionManager>) -> Self {
        sessionManager.failure(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler(self)
        }
        return self
    }
}


//
//  TRDownloadTask.swift
//  TiercelObjCBridge
//
//  Created by Daniels on 2019/11/18.
//  Copyright © 2019 Daniels. All rights reserved.
//

import UIKit
import Tiercel

@objcMembers public class TRDownloadTask: NSObject {

    @objc public enum TRValidation: Int {
        case unkown
        case correct
        case incorrect
    }

    private let downloadTask: DownloadTask

    public var filePath: String {
        return downloadTask.filePath
    }

    public var pathExtension: String? {
        return downloadTask.pathExtension
    }



    public var status: Status {
        return downloadTask.status
    }

    public var validation: TRValidation {

        switch downloadTask.validation {
        case .unkown:
            return .unkown
        case .correct:
            return .correct
        case .incorrect:
            return .incorrect
        }
    }

    public let url: URL



    public let progress: Progress = Progress()

    public var startDate: Double {
        return downloadTask.startDate
    }

    public var endDate: Double {
        return downloadTask.endDate
    }


    public var speed: Int64 {
        return downloadTask.speed
    }


    public var fileName: String {
        return downloadTask.fileName
    }

    public var timeRemaining: Int64 {
        return downloadTask.timeRemaining
    }

    public var error: Error? {
        return downloadTask.error
    }


    internal init(_ url: URL,
                  _ downloadTask: DownloadTask) {
        self.url = url
        self.downloadTask = downloadTask;
    }

}

//extension DownloadTask {
//    @discardableResult
//    public func validateFile(code: String,
//                             type: FileVerificationType,
//                             onMainQueue: Bool = true,
//                             _ handler: @escaping Handler<DownloadTask>) -> Self {
//        return operationQueue.sync {
//            if verificationCode == code &&
//                verificationType == type &&
//                validation != .unkown {
//                shouldValidateFile = false
//            } else {
//                shouldValidateFile = true
//                verificationCode = code
//                verificationType = type
//            }
//            self.validateExecuter = Executer(onMainQueue: onMainQueue, handler: handler)
//            if let manager = manager {
//                manager.cache.storeTasks(manager.tasks)
//            }
//            if status == .succeeded {
//                validateFile()
//            }
//            return self
//        }
//
//    }
//}
//
//extension Array where Element == DownloadTask {
//    @discardableResult
//    public func progress(onMainQueue: Bool = true, _ handler: @escaping Handler<DownloadTask>) -> [Element] {
//        self.forEach { $0.progress(onMainQueue: onMainQueue, handler) }
//        return self
//    }
//
//    @discardableResult
//    public func success(onMainQueue: Bool = true, _ handler: @escaping Handler<DownloadTask>) -> [Element] {
//        self.forEach { $0.success(onMainQueue: onMainQueue, handler) }
//        return self
//    }
//
//    @discardableResult
//    public func failure(onMainQueue: Bool = true, _ handler: @escaping Handler<DownloadTask>) -> [Element] {
//        self.forEach { $0.failure(onMainQueue: onMainQueue, handler) }
//        return self
//    }
//
//    public func validateFile(codes: [String],
//                             type: FileVerificationType,
//                             onMainQueue: Bool = true,
//                             _ handler: @escaping Handler<DownloadTask>) -> [Element] {
//        for (index, task) in self.enumerated() {
//            guard let code = codes.safeObject(at: index) else { continue }
//            task.validateFile(code: code, type: type, onMainQueue: onMainQueue, handler)
//        }
//        return self
//    }
//}

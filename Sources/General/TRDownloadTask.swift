//
//  TRDownloadTask.swift
//  TiercelObjCBridge
//
//  Created by Daniels on 2019/11/18.
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

@objcMembers public class TRDownloadTask: NSObject {

    @objc public enum TRValidation: Int {
        case unkown
        case correct
        case incorrect
    }

    internal let downloadTask: DownloadTask
    
    public var originalRequest: URLRequest? {
        downloadTask.originalRequest
    }

    public var currentRequest: URLRequest? {
        downloadTask.currentRequest
    }

    public var response: URLResponse? {
        downloadTask.response
    }
    
    public var statusCode: Int {
        downloadTask.statusCode ?? -1
    }

    public var filePath: String {
        return downloadTask.filePath
    }

    public var pathExtension: String? {
        return downloadTask.pathExtension
    }



    public var status: TRStatus {
        return TRStatus(downloadTask.status)
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

    public var url: URL {
        return downloadTask.url
    }


    public var progress: Progress {
        return downloadTask.progress
    }

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


    internal init(_ downloadTask: DownloadTask) {
        self.downloadTask = downloadTask;
    }
    
    
    @discardableResult
    public func validateFile(code: String,
                             type: TRFileVerificationType,
                             onMainQueue: Bool = true,
                             handler: @escaping Handler<TRDownloadTask>) -> Self {
        let convertType: FileVerificationType
        switch type {
        case .md5:
            convertType = .md5
        case .sha1:
            convertType = .sha1
        case .sha256:
            convertType = .sha256
        case .sha512:
            convertType = .sha512
        }
        downloadTask.validateFile(code: code, type: convertType, onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler(self)
        }
        return self
    }
    
    @discardableResult
    public func progress(onMainQueue: Bool = true, handler: @escaping Handler<TRDownloadTask>) -> Self {
        downloadTask.progress(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler(self)
        }
        return self
    }

    @discardableResult
    public func success(onMainQueue: Bool = true, handler: @escaping Handler<TRDownloadTask>) -> Self {
        downloadTask.success(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler(self)
        }
        return self

    }

    @discardableResult
    public func failure(onMainQueue: Bool = true, handler: @escaping Handler<TRDownloadTask>) -> Self {
        downloadTask.failure(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler(self)
        }
        return self
    }

}

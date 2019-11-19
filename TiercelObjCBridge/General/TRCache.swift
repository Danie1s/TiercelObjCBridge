//
//  TRCache.swift
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

import UIKit
import Tiercel

@objcMembers public class TRCache: NSObject {
    
    private let cache: Cache
    
    public var downloadPath: String {
        return cache.downloadPath
    }

    public var downloadTmpPath: String {
        return cache.downloadTmpPath
    }
    
    public var downloadFilePath: String {
        return cache.downloadFilePath
    }
    
    public var identifier: String {
        return cache.identifier
    }
    
    public init(_ name: String) {
        self.cache = Cache(name)
    }
    
    internal init(cache: Cache) {
        self.cache = cache
    }
    
    public func filePath(fileName: String) -> String? {
        return cache.filePath(fileName: fileName)
    }
    
    public func fileURL(fileName: String) -> URL? {
        return cache.fileURL(fileName: fileName)
    }
    
    public func fileExists(fileName: String) -> Bool {
        return cache.fileExists(fileName: fileName)

    }
    
    public func filePath(url: TRURLConvertible) -> String? {
        return cache.filePath(url: asURLConvertible(url))
    }
    
    public func fileURL(url: TRURLConvertible) -> URL? {
        return cache.fileURL(url: asURLConvertible(url))

    }
    
    public func fileExists(url: TRURLConvertible) -> Bool {
        return cache.fileExists(url: asURLConvertible(url))

    }
    
    
    
    public func clearDiskCache(onMainQueue: Bool, handler: Handler<TRCache>?) {
        cache.clearDiskCache(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler?(self)
        }
    }
    
    public func clearDiskCache() {
        clearDiskCache(onMainQueue: true, handler: nil)
    }

}




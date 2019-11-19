//
//  TRCache.swift
//  TiercelObjCBridge
//
//  Created by Daniels Lau on 2019/11/19.
//  Copyright © 2019 Daniels. All rights reserved.
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




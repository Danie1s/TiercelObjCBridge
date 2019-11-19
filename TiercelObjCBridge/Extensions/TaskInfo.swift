//
//  TaskInfo.swift
//  TiercelObjCBridge
//
//  Created by Daniels Lau on 2019/11/19.
//  Copyright © 2019 Daniels. All rights reserved.
//

import Foundation

extension NSNumber {
    
    /// 返回下载速度的字符串，如：1MB/s
    @objc public func tr_convertSpeedToString() -> String {
        let size = tr_convertBytesToString()
        return [size, "s"].joined(separator: "/")
    }
    
    /// 返回 00：00格式的字符串
    @objc public func tr_convertTimeToString() -> String {
        let formatter = DateComponentsFormatter()
        
        formatter.unitsStyle = .positional
        
        return formatter.string(from: TimeInterval(self.int64Value)) ?? ""
    }
    
    /// 返回字节大小的字符串
    @objc public func tr_convertBytesToString() -> String {
        return ByteCountFormatter.string(fromByteCount: Int64(self.int64Value), countStyle: .file)
    }
    
    
    @objc public func tr_convertTimeToDateString() -> String {
        let date = Date(timeIntervalSince1970: self.doubleValue)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
}


extension NSURL {
    
    @objc public var tr_fileName: String {
        return (self as URL).tr.fileName
    }
}

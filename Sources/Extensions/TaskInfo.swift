//
//  TaskInfo.swift
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

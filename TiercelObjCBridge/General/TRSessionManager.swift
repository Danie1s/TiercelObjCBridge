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

    @objc(initWithIdentifier:configuration:operationQueue:)
    public init(_ identifier: String,
                            configuration: TRSessionConfiguration,
                            operationQueue: DispatchQueue = DispatchQueue(label: "com.Tiercel.SessionManager.operationQueue")) {

        let config = SessionConfiguration();
        self.sessionManager = SessionManager.init(identifier, configuration: config, operationQueue: operationQueue)
        super.init()
    }

}



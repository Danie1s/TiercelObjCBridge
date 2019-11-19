//
//  AppDelegate.h
//  Demo
//
//  Created by Daniels on 2019/11/16.
//  Copyright © 2019 Daniels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TiercelObjCBridge/TiercelObjCBridge-Swift.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) TRSessionManager *sessionManager;

@end


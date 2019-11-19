//
//  AppDelegate.m
//  Demo
//
//  Created by Daniels on 2019/11/16.
//  Copyright © 2019 Daniels. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    TRSessionConfiguration *configuraion = [[TRSessionConfiguration alloc] init];
    self.sessionManager = [[TRSessionManager alloc] initWithIdentifier:@"ViewController" configuration:configuraion];
    
    return YES;
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler {
    if (identifier == self.sessionManager.identifier) {
        self.sessionManager.completionHandler = completionHandler;
    }
}




@end

//
//  ViewController.m
//  Demo
//
//  Created by Daniels on 2019/11/16.
//  Copyright © 2019 Daniels. All rights reserved.
//

#import "ViewController.h"
#import <TiercelObjCBridge/TiercelObjCBridge-Swift.h>
//#import "Demo-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    TRSessionConfiguration *config = [[TRSessionConfiguration alloc] init];
    TRSessionManager *manager = [[TRSessionManager alloc] initWithIdentifier:@"Daniels" configuration:config];
    [manager download:<#(id<TRURLConvertible> _Nonnull)#> headers:<#(NSDictionary<NSString *,NSString *> * _Nullable)#> fileName:<#(NSString * _Nullable)#>]

}


@end

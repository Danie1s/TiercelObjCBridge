//
//  ViewController.m
//  Demo
//
//  Created by Daniels on 2019/11/16.
//  Copyright © 2019 Daniels. All rights reserved.
//

#import "ViewController.h"
#import <TiercelObjCBridge/TiercelObjCBridge-Swift.h>
#import "AppDelegate.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *timeRemainingLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *validationLabel;

@property (nonatomic, strong) TRSessionManager *sessionManager;
@property (nonatomic, strong) NSString *URLString;

@end


@implementation ViewController

- (NSString *)URLString {
    
    if (!_URLString) {
//        _URLString = @"https://officecdn-microsoft-com.akamaized.net/pr/C1297A47-86C4-4C1F-97FA-950631F94777/OfficeMac/Microsoft_Office_2016_16.10.18021001_Installer.pkg";
        _URLString = @"http://dldir1.qq.com/qqfile/QQforMac/QQ_V4.2.4.dmg";
    }
    return _URLString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 检查磁盘空间
    int64_t free = [UIDevice currentDevice].tr_freeDiskSpaceInBytes / 1024 / 1024;
    NSLog(@"手机剩余储存空间为： %lld", free);

    TRSessionManager.logLevel = TRLogLevelSimple;

    self.sessionManager = ((AppDelegate *)[UIApplication sharedApplication].delegate).sessionManager;
    
    if (self.sessionManager.tasks.count > 0) {
        TRDownloadTask *task = self.sessionManager.tasks[0];
        [self updateUIWithTask:task];
    }

}

- (void)updateUIWithTask:(TRDownloadTask *)task {
    double per = task.progress.fractionCompleted;
    self.progressLabel.text = [NSString stringWithFormat:@"progress： %.2f%%", per * 100];
    self.progressView.progress = (float)per;
    self.speedLabel.text = [NSString stringWithFormat:@"speed： %@", [@(task.speed) tr_convertSpeedToString]];
    self.timeRemainingLabel.text = [NSString stringWithFormat:@"剩余时间： %@", [@(task.timeRemaining) tr_convertTimeToString]];
    self.startDateLabel.text = [NSString stringWithFormat:@"开始时间： %@", [@(task.startDate) tr_convertTimeToString]];
    self.endDateLabel.text = [NSString stringWithFormat:@"结束时间： %@", [@(task.endDate) tr_convertTimeToString]];
    NSString *validation;
    switch (task.validation) {
        case TRValidationUnkown:
            self.validationLabel.textColor = [UIColor blueColor];
            validation = @"未知";
            break;
        case TRValidationCorrect:
            self.validationLabel.textColor = [UIColor blueColor];
            validation = @"正确";
            break;
        case TRValidationIncorrect:
            self.validationLabel.textColor = [UIColor blueColor];
            validation = @"错误";
            break;
    }
    self.validationLabel.text = [NSString stringWithFormat:@"文件验证： %@", validation];

}

- (IBAction)start:(id)sender {
    __weak typeof(self) weakSelf = self;
    [[[[[self.sessionManager downloadWithUrl:self.URLString headers:nil fileName:nil] progressOnMainQueue:YES handler:^(TRDownloadTask * _Nonnull task) {
        [weakSelf updateUIWithTask:task];
    }] successOnMainQueue:YES handler:^(TRDownloadTask * _Nonnull task) {
        [weakSelf updateUIWithTask:task];
    }] failureOnMainQueue:YES handler:^(TRDownloadTask * _Nonnull task) {
        [weakSelf updateUIWithTask:task];
    }] validateFileWithCode:@"9e2a3650530b563da297c9246acaad5c" type:TRFileVerificationTypeMd5 onMainQueue:YES handler:^(TRDownloadTask * _Nonnull task) {
        [weakSelf updateUIWithTask:task];
        if (task.validation == TRValidationCorrect) {
            NSLog(@"文件正确");
        } else {
            NSLog(@"文件错误");
        }
    }];
}

- (IBAction)suspend:(id)sender {
    [self.sessionManager suspendWithUrl:self.URLString];
}

- (IBAction)cancel:(id)sender {
    [self.sessionManager cancelWithUrl:self.URLString];
}

- (IBAction)deleteTask:(id)sender {
    [self.sessionManager removeWithUrl:self.URLString];
}

- (IBAction)clearDisk:(id)sender {
    [self.sessionManager.cache clearDiskCache];
}

@end

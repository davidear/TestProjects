//
//  FirstViewController.m
//  TouchLock
//
//  Created by dai.fy on 15/4/30.
//  Copyright (c) 2015年 dai.fy. All rights reserved.
//

#import "FirstViewController.h"
#import "SSKeychain.h"
#import "VENTouchLock.h"
#import "ViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    BOOL isSet = [[VENTouchLock sharedInstance] isPasscodeSet];
    if (isSet) {
        MainViewController *vc = [[MainViewController alloc] init];
        vc.didFinishWithSuccess = ^(BOOL success, VENTouchLockSplashViewControllerUnlockType unlockType){
            
        };
        [self presentViewController:vc animated:NO completion:^{
            
        }];
    }else{
//        [self presentViewController:[[ViewController alloc] init] animated:YES completion:^{
//            
//        }];
        [[UIApplication sharedApplication].windows[0] setRootViewController:[[ViewController alloc] init]];
    }
}

- (IBAction)clearKeychain:(id)sender {
    [SSKeychain deletePasswordForService:@"TouchLock" account:[[NSUserDefaults standardUserDefaults] objectForKey:@"account"]];
    
}
@end

//
//  ViewController.m
//  test
//
//  Created by dai.fy on 15/5/3.
//  Copyright (c) 2015年 dai.fy. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()
@end

@implementation ViewController
{
    NSString *_implementation;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 44);
    [button setTitle:@"tiao" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
}

- (void)jump
{
    UIViewController *vc = [[UIViewController alloc] init];
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:navi animated:YES completion:nil];
}
@end

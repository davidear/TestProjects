//
//  ViewController.m
//  MyApp
//
//  Created by dfy on 15/2/14.
//  Copyright (c) 2015年 childrenAreOurFuture. All rights reserved.
//

#import "ViewController.h"
#import "MyLib.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyLib *lib = [[MyLib alloc] init];
    lib.good = @"123";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

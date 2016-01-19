//
//  ViewController.m
//  OnePXLineTest
//
//  Created by DaiFengyi on 15/12/31.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//

#import "ViewController.h"
#import "SAI1PXLine.h"
#import "DDThinLIne.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    SAI1PXLine *line = [[SAI1PXLine alloc] init];
//    line.backgroundColor = [UIColor redColor];
//    line.frame = self.view.bounds;
//    line.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    line.alpha = 0.6;
//    [self.view addSubview:line];
    
    UIImageView *defalut = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 280, 1)];
    defalut.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:defalut];
    
    DDThinLIne *line = [[DDThinLIne alloc] initWithFrame:CGRectMake(20, 100, 280, 1)];
    line.backgroundColor = [UIColor redColor];
    [self.view addSubview:line];
    
    [self.view setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

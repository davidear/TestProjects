//
//  ViewController.m
//  photoPicker
//
//  Created by dai.fengyi on 15/5/18.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "ViewController.h"
#import "JSGSettingHeaderVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)photoPicker:(id)sender {
    JSGSettingHeaderVC *vc = [[JSGSettingHeaderVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

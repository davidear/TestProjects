//
//  ViewController.m
//  block执行次序
//
//  Created by dai.fy on 15/5/1.
//  Copyright (c) 2015年 dai.fy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dict = @{@"a": @"1", @"b": @"2"};
    NSDictionary *dict2 = @{@"a": @"1", @"b": @"2"};
    NSDictionary *dict3 = @{@"a": @"1", @"b": @"2"};
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"key: %@, value: %@", key, obj);
        [dict2 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSLog(@"dic2 2key: %@, value: %@", key, obj);
            [dict3 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSLog(@"dic3 2key: %@, value: %@", key, obj);
                
            }];

        }];
    }];
    NSLog(@"nslog");

}

@end

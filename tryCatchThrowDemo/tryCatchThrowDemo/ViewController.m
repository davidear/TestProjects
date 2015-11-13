//
//  ViewController.m
//  tryCatchThrowDemo
//
//  Created by DaiFengyi on 15/10/31.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSInteger _result;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    @try {
        NSString *str = @"abc";
        [str substringFromIndex:111];
        NSLog(@"还被执行了吗？");
        //        _result = 5 / 0;
        //        @throw [NSException exceptionWithName:@"违反法则" reason:@"0不能被除" userInfo:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.description);
        _result = 0;
        //        @throw [NSException exceptionWithName:@"完蛋了" reason:@"死机了" userInfo:nil];
    }
    @finally {
        NSLog(@"see the result is %d", _result);
    }
}

@end

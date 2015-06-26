//
//  ViewController.m
//  CoreTextDemo
//
//  Created by dai.fengyi on 15/6/13.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "ViewController.h"

#import "CoreTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300)];
//    label.numberOfLines = 0;
//    label.backgroundColor = [UIColor brownColor];
//    [self.view addSubview:label];
//    
//    NSMutableAttributedString *mabstring = [[NSMutableAttributedString alloc] initWithString:@"This is a test of characterAttribute.中文字符" attributes:nil];
//    CTFontRef font = CTFontCreateWithName(CFSTR("Georgia"), 40, NULL);
//    [mabstring addAttribute:(id)kCTFontAttributeName value:(id)CFBridgingRelease(font) range:NSMakeRange(0, 4)];
//    
//    label.attributedText = mabstring;
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CoreTextView *textView = [[CoreTextView alloc] initWithFrame:CGRectMake(0, 20, 150, 200)];
    textView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:textView];
    

}

@end

//
//  ViewController.m
//  abc
//
//  Created by DaiFengyi on 15/9/21.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//

#import "ViewController.h"
#import "TTTAttributedLabel.h"
@interface ViewController ()<TTTAttributedLabelDelegate>
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *tttLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = NSLocalizedStringFromTable(@"hello", @"infoPlist", nil);
    label.center = self.view.center;
    [self.view addSubview:label];

    
    
    
    self.tttLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink; // Automatically detect links when the label text is subsequently changed
    self.tttLabel.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
    
    self.tttLabel.text = @"Fork me on GitHub! (http://github.com/mattt/TTTAttributedLabel/)"; // Repository URL will be automatically detected and linked
    
    NSRange range = [self.tttLabel.text rangeOfString:@"me"];
    [self.tttLabel addLinkToURL:[NSURL URLWithString:@"http://github.com/mattt/"] withRange:range];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.tttLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink; // Automatically detect links when the label text is subsequently changed
    self.tttLabel.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
    
    self.tttLabel.text = @"Fork me on GitHub! (http://github.com/mattt/TTTAttributedLabel/)"; // Repository URL will be automatically detected and linked
    
    NSRange range = [self.tttLabel.text rangeOfString:@"me"];
//    [self.tttLabel addLinkToURL:[NSURL URLWithString:@"http://github.com/mattt/"] withRange:range];
    [self.tttLabel addLinkToAddress:@{@"name" : @"无线"} withRange:range];
}
- (void)attributedLabel:(__unused TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    NSLog(@"hello,world");
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithAddress:(NSDictionary *)addressComponents {
    NSLog(@"abc");
}
@end

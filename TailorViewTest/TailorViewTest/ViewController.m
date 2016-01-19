//
//  ViewController.m
//  TailorViewTest
//
//  Created by DaiFengyi on 15/11/30.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//

#import "ViewController.h"
#import "SAITailorView.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()
@property (strong, nonatomic) SAITailorView *leftView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.leftView = [[SAITailorView alloc] init];
    [self.view addSubview:self.leftView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.leftView.frame = CGRectMake(0, 0, 200, 300);
    self.leftView.center = self.view.center;
    self.leftView.imageUrl = @"http://www.myexception.cn/u/cms/www/201501/18111025ldtl.jpg";
}
- (IBAction)switchImageUrl:(UIButton *)sender {
}

@end

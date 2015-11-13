//
//  ViewController.m
//  ScrollView联动
//
//  Created by DaiFengyi on 15/10/29.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *smallScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.smallScrollView.contentSize = CGSizeMake(800, 100);
    self.bigScrollView.contentSize = CGSizeMake(1200, 200);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.bigScrollView) {
        CGPoint offset = self.bigScrollView.contentOffset;
        self.smallScrollView.contentOffset = CGPointMake(offset.x / self.bigScrollView.bounds.size.width * self.smallScrollView.bounds.size.width, 0);
    }
}
@end

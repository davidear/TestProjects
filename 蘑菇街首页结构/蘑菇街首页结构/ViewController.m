//
//  ViewController.m
//  蘑菇街首页结构
//
//  Created by DaiFengyi on 16/1/25.
//  Copyright © 2016年 DaiFengyi. All rights reserved.
//
// 待验证的思路: 让tableView不可滑动，全展开
#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIView *topBanner;
@property (weak, nonatomic) IBOutlet UIScrollView *aScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bScrollView;
@property (weak, nonatomic) IBOutlet UIView *chennelSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize ss = [UIScreen mainScreen].bounds.size;
    
    self.mainScrollView.contentSize = CGSizeMake(ss.width, ss.height + 100 - 40);
    self.contentScrollView.contentSize = CGSizeMake(ss.width * 2, 0);
    
}


#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGRect channelFrame = self.chennelSlider.frame;
    CGPoint offset = scrollView.contentOffset;
    if (scrollView == self.contentScrollView) {
        NSLog(@"offset is %f", scrollView.contentOffset.x);
        if (scrollView.contentOffset.x == 0) {
            self.contentScrollView.frame = CGRectMake(0, 100, self.contentScrollView.bounds.size.width, self.aScrollView.frame.size.height);
            self.mainScrollView.contentSize = CGSizeMake(0, self.contentScrollView.bounds.size.height + 100 - 40);
            self.chennelSlider.frame = channelFrame;
            NSLog(@"A");
        }else {
            self.contentScrollView.frame = CGRectMake(0, 100, self.contentScrollView.bounds.size.width, self.bScrollView.frame.size.height);
            self.contentScrollView.contentOffset = offset;
            NSLog(@"contentScrollView frame is %@", NSStringFromCGRect(self.contentScrollView.frame));
            self.mainScrollView.contentSize = CGSizeMake(0, self.contentScrollView.bounds.size.height + 100 - 40);
            self.chennelSlider.frame = channelFrame;
            NSLog(@"B");
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.mainScrollView) {
        if (scrollView.contentOffset.y > 60) {
            self.chennelSlider.frame = CGRectMake(0, scrollView.contentOffset.y, self.chennelSlider.frame.size.width, self.chennelSlider.frame.size.height);
            NSLog(@"scrollView contentOffset y is %f, channel slider frame is %@",scrollView.contentOffset.y, NSStringFromCGRect(self.chennelSlider.frame));
        }
    }
}
@end

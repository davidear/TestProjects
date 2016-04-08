//
//  ViewController.m
//  PinterestTransitionDemo
//
//  Created by DaiFengyi on 16/4/7.
//  Copyright © 2016年 davidear. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark <RMPZoomTransitionAnimating>

- (UIImageView *)transitionSourceImageView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.imageView.image];
    imageView.contentMode = self.imageView.contentMode;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    imageView.frame = [self.imageView convertRect:self.imageView.frame toView:self.view];
    return imageView;
}

- (UIColor *)transitionSourceBackgroundColor
{
    return self.view.backgroundColor;
}

- (CGRect)transitionDestinationImageViewFrame
{
    CGRect cellFrameInSuperview = [self.imageView convertRect:self.imageView.frame toView:self.view];
    return cellFrameInSuperview;
}

@end

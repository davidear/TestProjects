//
//  ViewController.m
//  翻转
//
//  Created by DaiFengyi on 15/9/22.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
//@property (strong, nonatomic) UIView *firstView;
//@property (strong, nonatomic) UIView *secondView;
@end

@implementation ViewController
{
    UIView *fistView;
    UIView *secondView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *flipButton=[[UIBarButtonItem alloc]
                                 initWithTitle:@"翻转"
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(flip:)];
    self.navigationItem.rightBarButtonItem=flipButton;
    
    
    fistView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    fistView.tag=100;
    fistView.backgroundColor=[UIColor redColor];
    [self.view addSubview:fistView];
    
    secondView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    secondView.tag=101;
    secondView.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:secondView];
}


-(IBAction)flip:(id)sender{
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    
    
    //这里时查找视图里的子视图（这种情况查找，可能时因为父视图里面不只两个视图）
    NSInteger fist= [[self.view subviews] indexOfObject:[self.view viewWithTag:100]];
    NSInteger seconde= [[self.view subviews] indexOfObject:[self.view viewWithTag:101]];
    
    [self.view exchangeSubviewAtIndex:fist withSubviewAtIndex:seconde];
    
    //当父视图里面只有两个视图的时候，可以直接使用下面这段.
    
    //[self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
    
}

#pragma mark - extension
- (void)flipSubview:(UIView *)topView WithSubview:(UIView *)backView {
    if (![self.subviews containsObject:backView] | ![self.subviews containsObject:topView]) {
        return;
    }
    CGContextRef context=UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
    //    long topIndex = [self.subviews indexOfObject:topView];
    //    long backIndex = [self.subviews indexOfObject:backView];
    //    [self exchangeSubviewAtIndex:topIndex withSubviewAtIndex:backIndex];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}
@end

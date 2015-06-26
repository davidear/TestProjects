//
//  ViewController.m
//  clickZan
//
//  Created by Fairy on 14-8-12.
//  Copyright (c) 2014年 xian.song. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int i;
}

@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIImageView *image1;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CAAnimation *animation;
    CALayer *layer;
//    CAMediaTiming;
    CATransition
}
- (IBAction)change:(id)sender {
    
    [self.button1 setBackgroundImage :[UIImage imageNamed:(i%2==0?@"2":@"1")] forState:UIControlStateNormal];
    
    self.image1.layer.contents = (id)[UIImage imageNamed:(i%2==0?@"2":@"1")].CGImage;
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    k.duration = 1.0f;
    k.removedOnCompletion = NO;
    k.fillMode = kCAFillModeForwards;
    k.values = @[@(0.1),@(2.0),@(1.0)];
    k.keyTimes = @[@(0.0),@(0.5),@(1.0)];
    k.calculationMode = kCAAnimationLinear;

    i++;
    [self.button1.layer addAnimation:k forKey:@"SHOW"];
    [self.image1.layer addAnimation:k forKey:@"SHOW"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

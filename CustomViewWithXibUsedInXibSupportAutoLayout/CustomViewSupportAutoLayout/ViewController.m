//
//  ViewController.m
//  CustomViewSupportAutoLayout
//
//  Created by DaiFengyi on 15/9/27.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//

#import "ViewController.h"
#import "ComponentView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet ComponentView *componentViewContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    ComponentView *cv = (ComponentView *)[[[NSBundle mainBundle] loadNibNamed:@"ComponentView" owner:nil options:nil] lastObject];
    cv.frame = self.componentViewContainer.bounds;
    [self.componentViewContainer addSubview:cv];
//    self.view.contentMode = UIViewContentModeRedraw;
//    //不允许从Autoresizing转换Autolayout的Constraints
//    //貌似Storyboard创建时调用initWithCoder方法时translatesAutoresizingMaskIntoConstraints已经是NO了
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
}
- (IBAction)changeFrame:(id)sender {
    self.rightConstraint.constant = 100;
    [self.view layoutIfNeeded];
}

@end

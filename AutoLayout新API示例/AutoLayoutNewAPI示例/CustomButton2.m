//
//  CustomButton2.m
//  AutoLayoutNewAPI示例
//
//  Created by DaiFengyi on 15/11/13.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//

#import "CustomButton2.h"

@implementation CustomButton2
- (void)updateConstraints {
    NSLog(@"\n    2222updateConstraints");
    [super updateConstraints];
}
-(void)layoutSubviews {
    NSLog(@"\n    2222layoutsubviews");
    [super layoutSubviews];
    
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    NSLog(@"\n   2222drawRect");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

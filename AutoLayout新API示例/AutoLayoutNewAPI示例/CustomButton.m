//
//  CustomButton.m
//  AutoLayoutNewAPI示例
//
//  Created by DaiFengyi on 15/11/13.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (void)updateConstraints {
    NSLog(@"\nupdateConstraints");
    [super updateConstraints];
}
-(void)layoutSubviews {
    NSLog(@"\nlayoutsubviews");
    [super layoutSubviews];
    
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    NSLog(@"\ndrawRect");
}

//- (UIEdgeInsets)alignmentRectInsets {
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  FYCategoryButton.m
//  WYNews
//
//  Created by dai.fengyi on 15/6/29.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYCategoryButton.h"
#define kHeight                 40
#define kLabelSideMargin        60
#define kChannelLabelFont         14
@implementation FYCategoryButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:kChannelLabelFont];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:kChannelLabelFont]}];
//    size.height = kChannelHeaderHeight;
    size.width = size.width + kLabelSideMargin;
    size.height = kHeight;
    self.frame = (CGRect){self.bounds.origin, size};
}

//black rgb 000000
//#define kWYRed              [UIColor colorWithRed:221.0/255 green:50.0/255 blue:55.0/255 alpha:1]
//scale表示scrollView.contentOffset.x - label.bounds.origin.x与width的百分比
- (void)setScale:(CGFloat)scale
{
    _scale = scale;
//    NSLog(@"scale is %f", _scale);
    [self setTitleColor:[UIColor colorWithRed:(scale * (221.0 - 104.0) + 104.0)/255 green:(scale * (50.0 - 104.0) + 104.0)/255 blue:(scale * (55.0 - 104.0) + 104.0)/255 alpha:1] forState:UIControlStateNormal];
//    NSLog(@"\ncolor is %@", self.titleLabel.textColor);
    self.titleLabel.font = [UIFont systemFontOfSize:kChannelLabelFont * (1 + 0.3 * scale)];
}
@end
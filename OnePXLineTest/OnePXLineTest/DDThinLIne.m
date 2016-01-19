//
//  DDThinLIne.m
//  OnePXLineTest
//
//  Created by DaiFengyi on 16/1/7.
//  Copyright © 2016年 DaiFengyi. All rights reserved.
//

#import "DDThinLIne.h"

@implementation DDThinLIne

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"layoutSubviews");
    CGRect frame = self.frame;
    frame.size.height = (1.0 / [UIScreen mainScreen].scale);
    self.frame = frame;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    NSLog(@"drawRect");
//    // Drawing code
//    //获得处理的上下文
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    //设置线条样式
//    CGContextSetLineCap(context, kCGLineCapSquare);
//    //设置线条粗细宽度
//    CGContextSetLineWidth(context, (1.0 / [UIScreen mainScreen].scale));
//    //设置颜色
//    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 0.0, 1.0);
//    //开始一个起始路径
//    CGContextBeginPath(context);
//    //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
//    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
//    //设置下一个坐标点
//    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
//    //连接上面定义的坐标点
//    CGContextStrokePath(context);
//}


@end

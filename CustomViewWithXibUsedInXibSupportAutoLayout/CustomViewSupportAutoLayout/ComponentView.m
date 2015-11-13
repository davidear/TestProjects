//
//  ComponentView.m
//  CustomViewSupportAutoLayout
//
//  Created by DaiFengyi on 15/9/27.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//

#import "ComponentView.h"

@implementation ComponentView
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
//        self.contentMode = UIViewContentModeRedraw;
        //不允许从Autoresizing转换Autolayout的Constraints
        //貌似Storyboard创建时调用initWithCoder方法时translatesAutoresizingMaskIntoConstraints已经是NO了
//        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

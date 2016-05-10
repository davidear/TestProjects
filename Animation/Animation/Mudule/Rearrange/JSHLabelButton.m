//
//  JSHLabelButton.m
//  HotelVIP
//
//  Created by dai.fengyi on 15/6/1.
//  Copyright (c) 2015年 ZKJS. All rights reserved.
//

#import "JSHLabelButton.h"

@implementation JSHLabelButton
{
    UIImageView *_delete;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.cornerRadius = 5;
    
    _delete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_shanchu_nor"]];
    _delete.center = CGPointMake(self.frame.size.width - 2, 2);
    _delete.hidden = YES;
    [self addSubview:_delete];
}
- (void)setEdit:(BOOL)edit
{
    _edit = edit;
    if (_edit == YES) {
        _delete.hidden = NO;
    }else {
        _delete.hidden = YES;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  SAISegmentView.m
//  sai-iOS
//
//  Created by DaiFengyi on 15/10/21.
//  Copyright © 2015年 Malong Tech. All rights reserved.
//

#import "SAISegment.h"
#import "Masonry.h"
@implementation SAISegment {
    NSInteger _selectedIndex;
}
- (void)setItems:(NSArray *)items {
    for (NSString *title in items) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:title forState:UIControlStateNormal];
        [self addSubview:button];
    }
    [self setupSubviews];
    [self setupConstraint];
}
- (void)setupSubviews {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *) view;
            [button setBackgroundImage:[UIImage imageNamed:@"seg_bg_normal"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"seg_bg_highlight"] forState:UIControlStateSelected];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            if (self.subviews.firstObject == button) {
                button.selected = YES;
            }
        }
    }
}

- (void)setupConstraint {
    //    NSInteger count = self.subviews.count;
    UIView *lastView = nil;
    for (UIView *view in self.subviews) {
        __weak typeof(self) weakSelf = self;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView == nil) {
                make.left.equalTo(weakSelf.mas_left);
            } else {
                make.left.equalTo(lastView.mas_right);
                make.width.equalTo(lastView.mas_width);
            }
            if (view == weakSelf.subviews.lastObject) {
                make.right.equalTo(weakSelf.mas_right);
            }
            make.top.equalTo(weakSelf.mas_top);
            make.bottom.equalTo(weakSelf.mas_bottom);
        }];
        lastView = view;
    }
}

- (void)setTitle:(nullable NSString *)title forSegmentAtIndex:(NSUInteger)segment {
    UIView *view = self.subviews[segment];
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *) view;
        [button setTitle:title forState:UIControlStateNormal];
    }
}

#pragma mark - Button Action
- (void)click:(UIButton *)sender {
    if ([self.subviews indexOfObject:sender] == _selectedIndex) {
        sender.selected = NO;
        _selectedIndex = -1;
    }else {
        sender.selected = YES;
        if (_selectedIndex < self.subviews.count && _selectedIndex >= 0) {
            UIButton *button = (UIButton *)self.subviews[_selectedIndex];
            button.selected = NO;
        }
        _selectedIndex = [self.subviews indexOfObject:sender];
    }
    if ([self.delegate respondsToSelector:@selector(segmentView:Select:)]) {
        [self.delegate segmentView:self Select:_selectedIndex];
    }
}

#pragma mark - SAISegmentViewDelegate
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  FYChannelSlider.m
//  WYNews
//
//  Created by dai.fengyi on 15/5/27.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

//#import "FYCategoryButton.h"
#import "FYChannelSlider.h"
#define kWidthMargin 0
@interface FYChannelSlider () 
@property (assign, nonatomic) NSInteger oldIndex;
@end
@implementation FYChannelSlider {
    CGFloat _offsetX;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self addNotificationCenterObservers];
        _oldIndex = -1;//为什么是-1，需要在设置初值时（即0），触发KVO
    }
    return self;
}
#pragma mark - 初始化
- (void)setupUI {
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)addNotificationCenterObservers {
    [self addObserver:self forKeyPath:@"oldIndex" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setChannelArray:(NSArray *)channelArray {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _channelArray = channelArray;
    for (int i = 0; i < _channelArray.count; i++) {
        SAIChannel *channel = _channelArray[i];

        FYCategoryButton *button = [[FYCategoryButton alloc] init];
        //        button.text = channel.tname;
        [button setTitle:channel.channelName forState:UIControlStateNormal];
        [button addTarget:self action:@selector(categoryButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        if (self.subviews.count == 0) {
            button.frame = (CGRect){CGPointMake(kWidthMargin, 0), button.bounds.size};
        } else {
            button.frame = (CGRect){CGPointMake(CGRectGetMaxX([self.subviews.lastObject frame]) + kWidthMargin, 0), button.bounds.size};
        }
        [self addSubview:button];
    }
    self.contentSize = CGSizeMake(CGRectGetMaxX([self.subviews.lastObject frame]) + kWidthMargin, 0);

    //    self.offsetX = 0;
    // 给channelContainer设置数据
    if ([self.channelSliderDelegate isKindOfClass:[FYChannelContainer class]]) {
        FYChannelContainer *cc = (FYChannelContainer *) self.channelSliderDelegate;
        cc.channelArray = self.channelArray;
    }
    // 设置初始值
    [self categoryButtonSelected:self.subviews.firstObject];
}

//这个方法需要精简，影响性能
- (void)setOffsetX:(CGFloat)offsetX {
    _offsetX = offsetX;
    if (!_channelArray) {
        return;
    }
    float abc_offsetX = ABS(_offsetX);
    int index = (int) abc_offsetX;
    float delta = abc_offsetX - index;
    FYCategoryButton *oldButton = self.subviews[index];
    //    NSLog(@"old is %d , new is %d+1\n, index is %d", _oldIndex, _oldIndex + 1, index);
    oldButton.scale = 1 - delta;
    //最后一个
    if (index < _channelArray.count - 1) {
        FYCategoryButton *newbutton = self.subviews[index + 1];
        newbutton.scale = delta;
    }
    //整数才赋值
    if (index == abc_offsetX) {
        self.oldIndex = index;
    }
}

- (CGFloat)offsetX {
    return _offsetX;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UIView *oldView = self.subviews[_oldIndex];
    if (oldView.frame.origin.x <= self.contentOffset.x) {//超出左侧
        [self setContentOffset:CGPointMake(oldView.frame.origin.x, 0) animated:YES];
    }else if (CGRectGetMaxX(oldView.frame) > self.contentOffset.x + self.bounds.size.width) {//超出右侧
        [self setContentOffset:CGPointMake(CGRectGetMaxX(oldView.frame) - self.bounds.size.width, 0) animated:YES];
    }
}

#pragma mark - Button Action
- (void)categoryButtonSelected:(FYCategoryButton *)sender {
    //可优化,实现新旧按钮的变化
    _offsetX = [self.subviews indexOfObject:sender];
    if (_oldIndex >= 0 && _oldIndex <= self.channelArray.count - 1) {
        FYCategoryButton *oldButton = self.subviews[_oldIndex];
        oldButton.scale = 0;
    }
    sender.scale = 1;
    self.oldIndex = _offsetX;

    if ([self.channelSliderDelegate respondsToSelector:@selector(channelSliderDidSelected:)]) {
        [self.channelSliderDelegate channelSliderDidSelected:_offsetX];
    }
}

#pragma mark - FYChannelContainerDelegate
- (void)channelContainer:(FYChannelContainer *)channelContainer didScrollWithProportion:(CGFloat)offsetProportion {
    self.offsetX = offsetProportion;
}
@end
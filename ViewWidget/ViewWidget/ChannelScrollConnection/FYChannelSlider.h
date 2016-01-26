//
//  FYChannelSlider.h
//  WYNews
//
//  Created by dai.fengyi on 15/5/27.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYChannelContainer.h"
/**
 *  需求：
 1. 支持滑动自更新
 2. 支持点击自更新
 3. 支持主动设置
 4. 支持通知代理更新
 构建思路：
 1. 初始化：
    a. 通过channelArray来实现初始化
 2. 对内：
    a. 对于自身的滑动行为，自更新
    b. 对于自身的点击行为，自更新
 3. 对外：
    a. 接收代理消息，更新offset来实现更新
    b. 对于自身滑动行为，通过委托通知代理
 */
@protocol FYChannelSliderDelegate <NSObject>
- (void)channelSliderDidSelected:(NSInteger)index;
@end
@interface FYChannelSlider : UIScrollView <FYChannelContainerDelegate>
@property (weak, nonatomic) id<FYChannelSliderDelegate> channelSliderDelegate;
@property (weak, nonatomic) NSArray *channelArray;
@property (assign, nonatomic) CGFloat offsetX; //两个scrollView靠offsetX联系起来
@end

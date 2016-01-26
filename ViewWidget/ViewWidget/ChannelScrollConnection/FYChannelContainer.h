//
//  FYChannelContainer.h
//  sai-iOS
//
//  Created by DaiFengyi on 16/1/13.
//  Copyright © 2016年 Malong Tech. All rights reserved.
//
/**
 *  需求：
    1. 支持滑动切换数据源
    2. 支持通知代理更新
    3. 支持主动设置页码
    4. 获取targetTableView的滑动，根据规则设置其他tableView
    构建思路：
    1. 初始化：
        a. 通过channelArray来实现对scrollView的初始化，如有多大的contentsize
    2. 对内：
        a. 对于自身的滑动行为，自更新
        b. 通过执行协议方法，获取targetTableView滑动，然后设置其他tableView
    3. 对外：
        a. 暴漏setIndex来主动设置与滑动
        b. 对于自身滑动行为，通过委托通知代理
 */

/**
 *  FYChannelContainerTargetSubviewScrollDelegate是用于传递contentOffset
 */
#import <UIKit/UIKit.h>
#import "FYChannelSlider.h"
#define kBannelViewHeight ([UIScreen mainScreen].bounds.size.height * 0.26)
#define kChannelSliderHeight 40
#define kTopHeight (kBannelViewHeight + kChannelSliderHeight)
@protocol FYChannelContainerDelegate;
@protocol FYChannelContainerTargetSubviewScrollDelegate;
@interface FYChannelContainer : UIScrollView  <FYChannelSliderDelegate>
@property (weak, nonatomic) NSArray *channelArray;
@property (weak, nonatomic) id<FYChannelContainerDelegate> channelContainerDelegate;
@property (weak, nonatomic) id<FYChannelContainerTargetSubviewScrollDelegate> FYChannelContainerTargetSubviewScrollDelegate;
@end

@protocol FYChannelContainerDelegate <NSObject>
- (void)channelContainer:(FYChannelContainer *)channelContainer didScrollWithProportion:(CGFloat)offsetProportion;
@end

@protocol FYChannelContainerTargetSubviewScrollDelegate <NSObject>
- (void)targetSubviewDidScroll:(CGFloat)targetOffset;
@end
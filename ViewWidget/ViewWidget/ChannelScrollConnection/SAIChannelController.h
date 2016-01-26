//
//  SAIChannelController.h
//  sai-iOS
//
//  Created by Haihan Wang on 15/8/26.
//  Copyright (c) 2015年 malong tech. All rights reserved.
//

#import "SAIBaseTableViewController.h"
@protocol SAIChannelControllerDelegate;
@class SAIChannel;
@interface SAIChannelController : SAIBaseTableViewController
@property (weak, nonatomic) SAIChannel *channel;
@property (weak, nonatomic) id<SAIChannelControllerDelegate> channelControllerDelegate;

- (void)triggerRefresh;// 接受外部调用刷新
@end

// 用于将contentOffset传递出去，此写法比较呆板，但易理解
@protocol SAIChannelControllerDelegate <NSObject>
- (void)channelContentView:(UIScrollView *)tableView DidScroll:(CGFloat)targetOffset;
- (void)channelContentView:(UIScrollView *)tableView setOtherTableViewsContentOffset:(CGFloat)targetOffset;//用于调整其他并行tableView的contentOffset
@end

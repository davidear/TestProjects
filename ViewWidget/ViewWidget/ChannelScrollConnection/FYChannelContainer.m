//
//  FYChannelContainer.m
//  sai-iOS
//
//  Created by DaiFengyi on 16/1/13.
//  Copyright © 2016年 Malong Tech. All rights reserved.
//

#import "FYChannelContainer.h"
#import "Masonry.h"
#import "SAIChannelController.h"
#import "SAIDiscoveryConfig.h"
#define kReusePoolSize 6 //不低于3
@interface FYChannelContainer () <UIScrollViewDelegate, FYChannelSliderDelegate, SAIChannelControllerDelegate>
@property (strong, nonatomic) NSMutableArray *channelVCArray;
@property (assign, nonatomic) NSInteger index;
@end
@implementation FYChannelContainer
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.pagingEnabled = YES;
    self.delegate = self;
}
- (void)setChannelArray:(NSArray *)channelArray {
    _channelArray = channelArray;
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    // 判断区间
    if (index < 0 || index >= _channelArray.count) {
        return;
    }

    // 此处不能优化，注意顺序
    [self setupSubVCWithChannel:_channelArray[index] index:index];

    if (index - 1 >= 0) { // 左侧存在
        [self setupSubVCWithChannel:_channelArray[index - 1] index:index - 1];
    }
    if (index + 1 <= _channelArray.count - 1) { // 右侧存在
        [self setupSubVCWithChannel:_channelArray[index + 1] index:index + 1];
    }

    [self setContentOffset:CGPointMake(index * [UIScreen mainScreen].bounds.size.width, 0) animated:NO];
}

- (void)setupSubVCWithChannel:(SAIChannel *)channel index:(NSInteger)index {
    SAIChannelController *dc = [self dequeueChannelVCWithChannel:channel];
    [dc.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset([UIScreen mainScreen].bounds.size.width * index);
    }];
}

- (SAIChannelController *)dequeueChannelVCWithChannel:(SAIChannel *)channel {
    // 懒加载
    if (self.channelVCArray == nil) {
        self.channelVCArray = [NSMutableArray arrayWithCapacity:kReusePoolSize];
    }
    // 遍历查找
    __block SAIChannelController *target = nil;
    [self.channelVCArray enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([obj isKindOfClass:[SAIChannelController class]]) {
            SAIChannelController *dc = obj;
            if (dc.channel.channelId == channel.channelId) {
                target = obj;
                *stop = YES;
            }
        }
    }];
    // 根据结果编辑数组
    if (target == nil) {// 不存在该channel
        if (self.channelVCArray.count < kReusePoolSize) {// 数组未满，新增
            target = [[SAIChannelController alloc] initWithStyle:UITableViewStyleGrouped];
            target.channelControllerDelegate = self;
            // 加入视图
            [self addSubview:target.tableView];
            [self setupTableView:target.tableView];
            //加入数组
            [self.channelVCArray addObject:target];
        } else {// 数组已满，复用
            target = self.channelVCArray.firstObject;
        }
        // 赋新值
        target.channel = channel;
        [target triggerRefresh];
    }
    return target;
}

- (void)setupTableView:(UITableView *)tv {
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);

        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height);
    }];
    tv.contentInset = UIEdgeInsetsMake(kTopHeight, 0, 0, 0);
    tv.contentOffset = CGPointMake(0, -kTopHeight);
//    [tv setContentOffset:CGPointMake(0, kTopHeight) animated:YES];
    tv.scrollIndicatorInsets = UIEdgeInsetsMake(kTopHeight, 0, 0, 0);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentSize = CGSizeMake(_channelArray.count * self.bounds.size.width, 0);
}
//- (void)updateConstraints {
//
//
//    [super updateConstraints];
//}
#pragma mark - UIScrollView Delegate
// 用于自己翻页切换数据等等
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger index = (NSInteger)(offset / scrollView.bounds.size.width);
    [self setIndex:index];
    
    //主动触发两个代理方法，补充应对于滚动后不滑动tableView的情况，代理方法不触发
    
    SAIChannelController *cc = [self findControllerWithIndex:index];
    [self channelContentView:cc.tableView DidScroll:cc.tableView.contentOffset.y];
    [self channelContentView:cc.tableView setOtherTableViewsContentOffset:cc.tableView.contentOffset.y];
}

// 用于通知代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != self) {
        return;
    }
    if ([self.channelContainerDelegate respondsToSelector:@selector(channelContainer:didScrollWithProportion:)]) {
        CGFloat offsetProportion = scrollView.contentOffset.x / scrollView.bounds.size.width;
        [self.channelContainerDelegate channelContainer:self didScrollWithProportion:offsetProportion];
    }
}

#pragma mark - FYChannelSliderDelegate
- (void)channelSliderDidSelected:(NSInteger)index {
    [self setIndex:index];
}

#pragma mark - SAIChannelControllerDelegate
- (void)channelContentView:(UIScrollView *)tableView DidScroll:(CGFloat)targetOffset {
    SAIChannelController *cc = [self findControllerWithIndex:_index];
    if (tableView != cc.tableView) {// 过滤非targetTableView的调用
        return;
    }
    if ([self.FYChannelContainerTargetSubviewScrollDelegate respondsToSelector:@selector(targetSubviewDidScroll:)]) {
        [self.FYChannelContainerTargetSubviewScrollDelegate targetSubviewDidScroll:targetOffset];
    }
}

- (void)channelContentView:(UITableView *)tableView setOtherTableViewsContentOffset:(CGFloat)targetOffset {
    for (SAIChannelController *cc in self.channelVCArray) {
        if (tableView != cc.view) {
            if (targetOffset < -kTopHeight) {
                cc.tableView.contentOffset = CGPointMake(0, -kTopHeight);
            } else if (targetOffset >= -kChannelSliderHeight) {
                if (cc.tableView.contentOffset.y <= -kChannelSliderHeight) {
                    cc.tableView.contentOffset = CGPointMake(0, -kChannelSliderHeight);
                }
            } else {
                cc.tableView.contentOffset = CGPointMake(0, targetOffset);
            }
        }
    }
}

#pragma mark - Helper
- (SAIChannelController *)findControllerWithIndex:(NSInteger)index {
    SAIChannel *channel = self.channelArray[index];
    return [self findControllerWithChannelId:channel.channelId];
}

- (SAIChannelController *)findControllerWithChannelId:(long)channelId {
    for (SAIChannelController *cc in self.channelVCArray) {
        if (cc.channel.channelId == channelId) {
            return cc;
        }
    }
    return nil;
}
@end

//
//  SAIChannelController
//  sai-iOS
//
//  Created by Haihan Wang on 15/8/26.
//  Copyright (c) 2015年 malong tech. All rights reserved.
//

#import "MJRefresh.h" //refresh
#import "SAIAPI.h"
#import "SAIChannelController.h"
#import "SAIConfigHelper.h"
#import "SAIConstant.h"
#import "SAIDiscoveryConfig.h"
#import "SAIDiscoveryTableViewCell.h"
#import "SAIFixediCard.h"
#import "SAIICardDetailController.h"
#import "SAIMonitor.h"
#import "SAINavigationController.h"
#import "SAIStroe.h"
#import "SAIUserInfoHeader.h"
#import "SAIUtil.h"
#import "SAIiCardTag.h"
#import "UIColor+Chameleon.h" //color
@interface SAIChannelController ()
@end

@implementation SAIChannelController {
    // for load data
    NSInteger _page; // current page, so load more data with _page + 1
    NSMutableArray *_tagArray;
    NSInteger _errorTime;
}
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupData];
    [self setupSubviews];
    self.iCardSource = [SAIStroe latestStore];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setupSubviews {
    self.tableView.allowsSelection = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 500;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"EFEFF4"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 49, 0);
    //    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);

    // refresh
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
    }];
    header.arrowView.image = [UIImage imageNamed:@"array_down_refresh"];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
    //    header.lastUpdatedTimeText = ^(NSDate *lastUpdatedTime) {
    //        return [NSString stringWithFormat:@"%@", lastUpdatedTime];
    //    };
    header.lastUpdatedTimeLabel.hidden = YES;

    self.tableView.mj_header = header;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];

    // tableview
    UINib *nib = [UINib nibWithNibName:@"SAIDiscoveryTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"SAIDiscoveryTableViewCell"];
}

- (void)triggerRefresh {
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - Initial Setup
- (void)setupData {
    // for load data
    _page = 0;
    _tagArray = [NSMutableArray array];
}

#pragma mark - Load Data
- (void)loadMoreData {
    __weak typeof(self) weakSelf = self;
    [SAIMonitor trackEvent:monitor_event_discovery_more eventLabel:monitor_eventLabel_discovery_latest];
    long score = ((SAIFixediCard *) [weakSelf.iCardSource getItems].lastObject).score;
    [SAIAPI Business_Cards_ByChannel:self.channel.channelId
        count:@(kPageSize)
        score:score
        tags:_tagArray
        success:^(NSMutableArray *fixediCards) {
            if (fixediCards.count == 0) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            _page++;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.iCardSource addMoreItems:fixediCards];
                [weakSelf.tableView insertSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(_page * kPageSize, kPageSize)]
                                  withRowAnimation:UITableViewRowAnimationBottom];
                //                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_footer endRefreshing];
            });
        }
        failure:^(NSError *error) {
            [weakSelf.tableView.mj_footer endRefreshing];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"加载失败"
                                                            message:@"Opps,小AI的网线被拔掉了."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            [SAIMonitor trackError:monitor_eventLabel_error_loadLatest error:error];
        }];
}
- (void)refreshData {
    __weak typeof(self) weakSelf = self;
    [SAIMonitor trackEvent:monitor_event_discovery_refresh eventLabel:monitor_eventLabel_discovery_latest];
    [SAIAPI Business_Cards_ByChannel:self.channel.channelId
        count:@(kPageSize)
        score:0
        tags:_tagArray
        success:^(NSMutableArray *fixediCards) {
            _page = 0;
            [weakSelf.iCardSource resetItems:fixediCards];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer resetNoMoreData]; //重置footer状态
                                                            //            weakSelf.tableView.contentOffset = CGPointMake(0, -140);
        }
        failure:^(NSError *error) {
            if (error.code == 401 && _errorTime == 0) {
                // try one more for token expire but have no login again.
                _errorTime = 1;
                [weakSelf refreshData];
                return;
            }

            [weakSelf.tableView.mj_header endRefreshing];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"刷新失败"
                                                            message:@"Opps,小AI的网线被拔掉了."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            [SAIMonitor trackError:monitor_eventLabel_error_loadLatest error:error];
        }];
}

#pragma mark - Scroll View
//下面两个方法用于监听滑动结果，此结果会影响其他并行tableView，通过委托传递出去
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //更新所有view
    if ([self.channelControllerDelegate respondsToSelector:@selector(channelContentView:setOtherTableViewsContentOffset:)]) {
        //        NSLog(@"self.channelid is %@", self.channel.channelName);
        [self.channelControllerDelegate channelContentView:scrollView setOtherTableViewsContentOffset:scrollView.contentOffset.y];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        //更新所有view
        if ([self.channelControllerDelegate respondsToSelector:@selector(channelContentView:setOtherTableViewsContentOffset:)]) {
            //            NSLog(@"self.channelid is %@", self.channel.channelName);
            [self.channelControllerDelegate channelContentView:scrollView setOtherTableViewsContentOffset:scrollView.contentOffset.y];
        }
    }
}

// 这个方法会监听到由refresh触发的scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.channelControllerDelegate respondsToSelector:@selector(channelContentView:DidScroll:)]) {
        [self.channelControllerDelegate channelContentView:scrollView DidScroll:scrollView.contentOffset.y];
    }
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = [[self.iCardSource getItems] count];
    return count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SAIUserInfoHeader *header = [[SAIUserInfoHeader alloc] init];
    header.superController = self;
//    header.showDate = NO;
    NSArray *iCards = [self.iCardSource getItems];
    SAIFixediCard *iCard = iCards[section];
    header.iCard = iCard;
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SAIDiscoveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SAIDiscoveryTableViewCell" forIndexPath:indexPath];
    cell.superController = self;
    cell.removeGraySeperator = YES;
    NSArray *iCards = [self.iCardSource getItems];
    SAIFixediCard *iCard = iCards[indexPath.section];
    cell.iCard = iCard;
    cell.moreAction = iCardMoreAction_Report;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *iCards = [self.iCardSource getItems];
    SAIFixediCard *iCard = iCards[indexPath.section];

    SAIICardDetailController *idc = [[SAIICardDetailController alloc] initWithiCard:iCard showKeyboard:NO];

    [[NSNotificationCenter defaultCenter] postNotificationName:ACTION_DISCOVERY_JUMP_ICARDDETAIL object:idc];
    //    [self.navigationController pushViewController:idc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end

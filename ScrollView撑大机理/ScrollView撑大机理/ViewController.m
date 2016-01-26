//
//  ViewController.m
//  ScrollView撑大机理
//
//  Created by DaiFengyi on 16/1/26.
//  Copyright © 2016年 DaiFengyi. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()<UIScrollViewDelegate, UITableViewDataSource,UITableViewDelegate>
//@property (weak, nonatomic) IBOutlet UIScrollView *bigScroll;
//@property (weak, nonatomic) IBOutlet UIScrollView *midScroll;
//@property (weak, nonatomic) IBOutlet UIScrollView *internalScroll;
@property (strong, nonatomic) UILabel *topView;
@property (strong, nonatomic) NSMutableArray *tvArray;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (assign, nonatomic) NSInteger oldindex;
@end

@implementation ViewController
- (UIView *)blankView {
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 150)];
    v.backgroundColor = [UIColor blueColor];
    return v;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubviews];
}


- (void)initSubviews {
    self.oldindex = 0;
    self.tvArray = [NSMutableArray array];
    
    self.mainScrollView.pagingEnabled = YES;
    
    
    self.topView = [[UILabel alloc] init];
    self.topView.text = @"hello, world!";
    self.topView.backgroundColor = [UIColor redColor];
    
    for (NSInteger i = 0; i < 5; i++) {
        UITableView *tv = [[UITableView alloc] init];
        tv.backgroundColor = [UIColor grayColor];
        tv.dataSource = self;
        tv.delegate = self;
        UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 150)];
        top.backgroundColor = [UIColor purpleColor];
        tv.tableHeaderView = top;
        [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"abc"];
        
        [self.mainScrollView addSubview:tv];
        [self.tvArray addObject:tv];
        [tv mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(self.mainScrollView.mas_left);
            }else {
                UITableView *last = self.tvArray[ i - 1];
                make.left.equalTo(last.mas_right);
            }
            if (i == 4) {
                make.right.equalTo(self.mainScrollView.mas_right);
            }
            make.top.equalTo(self.mainScrollView.mas_top);
            make.bottom.equalTo(self.mainScrollView.mas_bottom);
            make.width.equalTo(self.mainScrollView.mas_width);
            make.height.equalTo(self.mainScrollView.mas_height);
        }];
    }
    
    [self.mainScrollView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainScrollView.mas_top);
        make.left.equalTo(self.mainScrollView.mas_left);
        make.width.equalTo(self.mainScrollView.mas_width);
        make.height.equalTo(@150);
    }];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.mainScrollView) {
        //从旧的tableView的header中移除
        UITableView *tv = self.tvArray[self.oldindex];
        [self.topView removeFromSuperview];
        //加入到mainScroll中
        if (![self.mainScrollView.subviews containsObject:self.topView]) {
            [self.mainScrollView addSubview:self.topView];
        }
        //设置其在mainScroll中的frame，此时的y值参考tv的contentOffset.y
        [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(-tv.contentOffset.y));
            make.width.equalTo(self.mainScrollView.mas_width);
            make.height.equalTo(@150);
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.mainScrollView) {
        //跟随mainScroll的滑动更新位置（此时处在mainScroll中）
        [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mainScrollView.mas_left).with.offset(scrollView.contentOffset.x);
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ( scrollView == self.mainScrollView) {
        NSInteger index = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
        UITableView *tv = self.tvArray[index];
        //从mainScrollView中移除
        [self.topView removeFromSuperview];
        //加入到新的tableView的header中
        [tv.tableHeaderView addSubview:self.topView];
        //设置相关尺寸
        [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tv.tableHeaderView.mas_left);
            make.top.equalTo(tv.tableHeaderView.mas_top);
            make.width.equalTo(self.mainScrollView.mas_width);
            make.height.equalTo(@150);
        }];
        
        //更新oldindex
        self.oldindex = index;
    }
}
#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"abc"];
    cell.textLabel.text = [NSString stringWithFormat:@"index.row is %ld", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%@", self.topView);
}
@end

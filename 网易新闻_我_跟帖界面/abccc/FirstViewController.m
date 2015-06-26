//
//  FirstViewController.m
//  abccc
//
//  Created by dai.fengyi on 15/6/24.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"abc"];
    
//    self.scrollView.contentSize = CGSizeMake(0, 1200);
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 150)];
//    view.backgroundColor = [UIColor blueColor];
//    self.tableView.tableHeaderView = view;
//    self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
//    self.tableView.bounces = NO;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(100, 0, 0, 0);

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return  150;
//}
//- (UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 150)];
//        view.backgroundColor = [UIColor redColor];
//        view.layer.borderWidth = 1;
//        view.layer.borderColor = [UIColor blueColor].CGColor;
//        return view;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"abc"];
    cell.textLabel.text = @"abb";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect frame = _headerView.frame;
        NSLog(@"%f", _tableView.contentOffset.y);
    if (_tableView.contentOffset.y <= -44 & _tableView.contentOffset.y >= -100) {
        frame.size.height = fabs(_tableView.contentOffset.y);
    }else if (_tableView.contentOffset.y < -100) {
        frame.size.height = 100;
    }else {
        frame.size.height = 44;
    }
    _headerView.frame = frame;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%f", _tableView.contentOffset.y);
}
@end

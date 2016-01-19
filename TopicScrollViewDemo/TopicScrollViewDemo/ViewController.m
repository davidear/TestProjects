//
//  ViewController.m
//  TopicScrollViewDemo
//
//  Created by DaiFengyi on 16/1/11.
//  Copyright © 2016年 DaiFengyi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *firstScrollView;

@property (assign, nonatomic) CGFloat rectY;
@property (assign, nonatomic) CGFloat rectH;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.bigScrollView.contentSize = CGSizeMake(0, 1000);
    self.bigScrollView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    self.firstScrollView.delegate = self;
    self.firstScrollView.contentSize = CGSizeMake(0, 1000);
    self.bigScrollView.delegate = self;
    self.rectY = self.firstScrollView.frame.origin.y;
    self.rectH = self.firstScrollView.frame.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.firstScrollView) {
        CGRect rect = self.firstScrollView.frame;
        NSLog(NSStringFromCGPoint(scrollView.contentOffset));
        self.firstScrollView.frame = CGRectMake(rect.origin.x, self.rectY , rect.size.width, self.rectH + scrollView.contentOffset.y);
        self.bigScrollView.contentOffset = scrollView.contentOffset;
    }
}

@end

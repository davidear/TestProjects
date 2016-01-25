//
//  JSBSNewFeatureController.m
//
//
//  Created by dai.fengyi on 15/4/22.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "FYNewFeatureController.h"

#define kCount 5

@interface FYNewFeatureController () <UIScrollViewDelegate>
@property (strong, nonatomic) UIViewController *root;
@property (weak, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIScrollView *scroll;
@property (strong, nonatomic) UIPageControl *page;

@end

@implementation FYNewFeatureController
+ (void)showNewFeatureBeforeRootViewController:(UIViewController *)root window:(UIWindow *)window {
    NSNumber *isShow = [[NSUserDefaults standardUserDefaults] objectForKey:@"Introduce"];
    if (isShow.boolValue) {
        window.rootViewController = root;
    } else {
        FYNewFeatureController *nfc = [[FYNewFeatureController alloc] init];
        nfc.root = root;
        nfc.window = window;
        window.rootViewController = nfc;
    }
}
#pragma mark 
- (BOOL)prefersStatusBarHidden {
    return YES;
}
#pragma mark 自定义view
//- (void)loadView
//{
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.image = [UIImage imageNamed:@"new_feature_background.png"];
//    /*
//     以3.5inch为例（320x480）
//     1> 当没有状态栏，applicationFrame的值{{0, 0}, {320, 480}}
//     2> 当有状态栏，applicationFrame的值{{0, 20}, {320, 460}}
//     */
//    imageView.frame = [UIScreen mainScreen].applicationFrame;
//    // 跟用户进行交互（这样才可以接收触摸事件）
//    imageView.userInteractionEnabled = YES;
//    self.view = imageView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1.添加UIScrollView
    [self addScrollView];
    // 2.添加图片
    [self addScrollImages];
    // 3.添加UIPageControl
    [self addPageControl];
}

#pragma mark - UI界面初始化
#pragma mark 添加滚动视图
- (void)addScrollView {
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.frame = self.view.bounds;
    scroll.showsHorizontalScrollIndicator = NO; // 隐藏水平滚动条
    CGSize size = scroll.frame.size;
    scroll.contentSize = CGSizeMake(size.width * kCount, 0); // 内容尺寸
    scroll.pagingEnabled = YES;                              // 分页
    scroll.bounces = NO;
    scroll.delegate = self;
    [self.view addSubview:scroll];
    self.scroll = scroll;
}

#pragma mark 添加滚动显示的图片
- (void)addScrollImages {
    CGSize size = _scroll.frame.size;

    for (int i = 0; i < kCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        // 1.显示图片
        NSString *name = [NSString stringWithFormat:@"slide%d.png", i + 1];
        imageView.image = [UIImage imageNamed:name];
        // 2.设置frame
        imageView.frame = CGRectMake(i * size.width, 0, size.width, size.height);
        [_scroll addSubview:imageView];

        if (i == kCount - 1) { // 最后一页，添加2个按钮
            // 3.立即体验（开始）
            UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
            [start setImage:[UIImage imageNamed:@"slide_start"] forState:UIControlStateNormal];
            start.bounds = CGRectMake(0, 0, 192, 68);
            start.center = CGPointMake(size.width * 0.5, size.height * 0.8);
            [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:start];

            /*
            // 4.分享
            UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
            // 普通状态显示的图片（selected=NO）
            UIImage *shareNormal = [UIImage imageNamed:@"new_feature_share_false.png"];
            [share setBackgroundImage:shareNormal forState:UIControlStateNormal];
            // 选中状态显示的图片（selected=YES）
            [share setBackgroundImage:[UIImage imageNamed:@"new_feature_share_true.png"] forState:UIControlStateSelected];

            share.center = CGPointMake(start.center.x, start.center.y - 50);
            share.bounds = (CGRect){CGPointZero, shareNormal.size};
            [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];

            // 代表按钮变为UIControlStateDisabled状态
            //            share.enabled = NO;
            // 设置选中
            share.selected = YES;

            // 按钮在高亮的时候不需要变灰色
            share.adjustsImageWhenHighlighted = NO;

            [imageView addSubview:share];
             */

            imageView.userInteractionEnabled = YES;
        }
    }
}

#pragma mark 添加分页指示器
- (void)addPageControl {
    CGSize size = self.view.frame.size;
    UIPageControl *page = [[UIPageControl alloc] init];
    page.center = CGPointMake(size.width * 0.5, size.height * 0.95);
    page.numberOfPages = kCount;
//    page.currentPageIndicatorTintColor = [UIColor whiteColor];
//    page.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"]];
//    page.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point.png"]];
    page.bounds = CGRectMake(0, 0, 150, 0);
    [self.view addSubview:page];
    self.page = page;
}

#pragma mark - 监听按钮点击
#pragma mark 开始
- (void)start {
    self.window.rootViewController = self.root;
    // 为了每次显示，注释掉了该行代码
//    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"Introduce"];
    
    // 用下列动画会造成statusBar的显示问题
//    [UIView transitionWithView:self.window duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//        self.window.rootViewController = self.root;
//    } completion:^(BOOL finished) {
//    }];
}

//#pragma mark 分享
//- (void)share:(UIButton *)btn {
//    btn.selected = !btn.selected;
//}

#pragma mark - 滚动代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.page.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        self.page.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    }
}

@end

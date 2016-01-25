//
//  FYScrollBanner.m
//  
//
//  Created by dfy on 15/1/27.
//  Copyright (c) 2015年 childrenAreOurFuture. All rights reserved.
//
// if you like to support autolayout, open the annotations
#import "FYScrollBanner.h"
//#import "Masonry.h"
@interface FYBannerItem : UIButton
@end
@implementation FYBannerItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
@end

#define kTimerDuration 5
@interface FYScrollBanner ()<UIScrollViewDelegate>
// 滚动视图
@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIPageControl *pageControl;
//记录最初展示的序号
@property (assign, nonatomic) NSInteger index;

// 保存滚动视图显示内容的图像视图数组，数组中一共有三张图片
@property (strong, nonatomic) NSArray *bannerItemList;


@end
@implementation FYScrollBanner
#pragma mark - Life Cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initSubviews];
//        [self setupSubviewsWithAutolayout];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame index:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        [self setupSubviews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSubviews];
}
#pragma mark - Initial Setup
- (void)initSubviews {
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:scroll];
    self.scrollView = scroll;
    
    // 4. 创建图像视图的数组
    NSMutableArray *bannerItemList = [NSMutableArray arrayWithCapacity:3];
    for (NSInteger i = 0; i < 3; i++) {
        FYBannerItem *bannerItem = [[FYBannerItem alloc] init];
        [bannerItemList addObject:bannerItem];
        [scroll addSubview:bannerItem];
        
    }
    self.bannerItemList = bannerItemList;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self addSubview:pageControl];
}

- (void)setupSubviews {
    // 设置内部bannerItem
    for (NSInteger i = 0; i < 3; i++) {
        FYBannerItem *bannerItem = self.bannerItemList[i];
        bannerItem.frame = (CGRect){CGPointMake(i * self.frame.size.width, 0), self.frame.size};
    }
    [self commonSetup];
}

//- (void)setupSubviewsWithAutolayout {
//    // 设置scrollView
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
//    
//    // 设置内部bannerItem
//    for (NSInteger i = 0; i < 3; i++) {
//        UIView *v = self.bannerItemList[i];
//        [v mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.scrollView.mas_top);
//            if (i == 0) {
//                make.left.equalTo(self.scrollView.mas_left);
//            }else {
//                make.left.equalTo(((UIView *)(self.bannerItemList[i - 1])).mas_right);
//            }
//            make.bottom.equalTo(self.scrollView.mas_bottom);
//            if (i == 2) {
//                make.right.equalTo(self.scrollView.mas_right);
//            }
//            
//            make.size.equalTo(self);
//        }];
//    }
//    
//    [self commonSetup];
//}

- (void)commonSetup {
    self.index = 0;
    // 设置滚动视图的属性
    CGFloat width = self.scrollView.bounds.size.width;
    self.scrollView.contentSize = CGSizeMake(width * 3, 0);
    [self.scrollView setBounces:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setDelegate:self];
    [self.scrollView setPagingEnabled:YES];
    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    
    // pageControl
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [self.pageControl setPageIndicatorTintColor:[UIColor blackColor]];
    self.pageControl.numberOfPages = self.imageList.count;
    self.pageControl.currentPage = 0;
    [self.pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
    
    // 设置内部bannerItem
    for (NSInteger i = 0; i < 3; i++) {
        FYBannerItem *bannerItem = self.bannerItemList[i];
        bannerItem.frame = (CGRect){CGPointMake(i * self.frame.size.width, 0), self.frame.size};
    }
    
    // 设置初始值
    [self resetBannerImages];
    [self.scrollView setContentOffset:CGPointMake(width, 0)];
    
    // 加入定时器
    [NSTimer scheduledTimerWithTimeInterval:kTimerDuration target:self selector:@selector(turnPage) userInfo:nil repeats:YES];
}

#pragma mark - Setter
-(void)setImageList:(NSMutableArray *)imageList {
    _imageList = imageList;
    [self resetBannerImages];
}

#pragma mark 定时器
- (void)turnPage
{
    CGFloat width = self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(2 * width, 0) animated:YES];
}
#pragma mark - 根据页号，设置滚动视图显示内容
// 图片位置是 0 1 2
- (void)resetBannerImages {
    NSInteger imageCount = self.imageList.count;
    for (NSInteger i = 0; i <= 2; i++) {
        UIImage *image = self.imageList[(self.index - 1 + i + imageCount) % imageCount];
        // 取出图像视图数组中的图像视图
        FYBannerItem *bannerItem = self.bannerItemList[i];
        // 设置图像
        [bannerItem setImage:image forState:UIControlStateNormal];
    }
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self afterScroll:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self afterScroll:scrollView];
}

- (void)afterScroll:(UIScrollView *)scrollView {
    // 1. 计算页号
    NSInteger pageNo = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    if (pageNo == 1) {
        return;
    }
    if (pageNo == 0) {
        self.index--;
    }
    if (pageNo == 2) {
        self.index++;
    }
    
    [self resetBannerImages];
    // 注意：其他页面同样需要处理，因为，图片缓存数组中只有三张图片
    [scrollView setContentOffset:CGPointMake(scrollView.bounds.size.width, 0)];
}
@end

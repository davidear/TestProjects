//
//  RearrangeController.m
//
//
//  Created by dai.fengyi on 15/6/2.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "RearrageController.h"
#import "JSHLabelChooseView.h"

@interface RearrageController ()<LabelChooseDelegate>
@property (strong , nonatomic) NSMutableArray *itemArray;
@end

@implementation RearrageController
{
    JSHLabelChooseView *_chooseView;
//    NSMutableArray *_textArray;
//    NSMutableArray *_buttonArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupSubviews];
    [self loadData];
}
- (void)loadData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JSHBookLabels" ofType:@"plist"];

    _chooseView.dataArray = [NSArray arrayWithContentsOfFile:path];
}
- (void)initSubviews {
    _chooseView = [[JSHLabelChooseView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_chooseView];
}

- (void)setupSubviews {
    _chooseView.frame = CGRectInset([UIScreen mainScreen].bounds, 0, 64);
    _chooseView.backgroundColor = [UIColor redColor];
    _chooseView.delegate = self;
}
@end

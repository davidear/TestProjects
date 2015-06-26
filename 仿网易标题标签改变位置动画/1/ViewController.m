//
//  ViewController.m
//  1
//
//  Created by dai.fengyi on 15/6/2.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "ViewController.h"
#import "JSHLabelChooseView.h"

@interface ViewController ()<LabelChooseDelegate>
@property (strong , nonatomic) NSMutableArray *itemArray;
@end

@implementation ViewController
{
    JSHLabelChooseView *_chooseView;
//    NSMutableArray *_textArray;
//    NSMutableArray *_buttonArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initSubviews];
    [self loadData];
}
- (void)loadData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JSHBookLabels" ofType:@"plist"];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    _chooseView.dataArray = [NSArray arrayWithContentsOfFile:path];
//    
//    _textArray = [NSMutableArray array];
//    _buttonArray = [NSMutableArray array];
}
- (void)initSubviews
{
    _chooseView = [[JSHLabelChooseView alloc] initWithFrame:self.view.bounds];
    _chooseView.frame = CGRectInset(self.view.bounds, 0, 20);
    _chooseView.backgroundColor = [UIColor redColor];
    _chooseView.delegate = self;
    [self.view addSubview:_chooseView];
}

@end

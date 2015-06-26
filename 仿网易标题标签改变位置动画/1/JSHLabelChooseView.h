//
//  JSHLabelChooseView.h
//  HotelVIP
//
//  Created by dai.fengyi on 15/6/1.
//  Copyright (c) 2015年 ZKJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSHLabelButton.h"
#define kMarginH            10
#define kMarginW            15
#define kCountOfARow        4
#define kButtonHeight       30
@protocol LabelChooseDelegate <NSObject>
- (void)didSelectedButton:(JSHLabelButton *)button;

@end
@interface JSHLabelChooseView : UIScrollView
@property (weak, nonatomic) id<LabelChooseDelegate> delegate;
@property (strong, nonatomic) NSArray *dataArray;
@end

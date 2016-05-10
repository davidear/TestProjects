//
//  JSHLabelChooseView.m
//  HotelVIP
//
//  Created by dai.fengyi on 15/6/1.
//  Copyright (c) 2015年 ZKJS. All rights reserved.
//
//通过改变按钮的数组次序，然后重新铺排数组来完成效果
//1 增加一个占位button，在每次拖动按钮到其他button区域内时，修改button数组，删除旧placeholder，重新加入placeholder到指定位置，并refreshview
//2 1情况中，第一次时，placeholder为nil时，初始化placeholder，删除拖动按钮，加入placeholder至指定位置
//3 在松手时，两步：
//3.1 将拖动button替换placeholder
//3.2 恢复button的属性，alpha和scale

#import "JSHLabelChooseView.h"

#define kDuration       1.0f
@implementation JSHLabelChooseView
{
    NSMutableArray *_buttonArray;
    JSHLabelButton *_placeHolder;
}

- (void)setDataArray:(NSArray *)dataArray
{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    self.backgroundColor = [UIColor clearColor];
    
    _dataArray = dataArray;
    if (_dataArray == nil) {
        return;
    }
    [self initSubviewsWithData:_dataArray];
    
//    UIView *lastObject = [self.subviews lastObject];
//    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(lastObject.frame) + kMarginH);
//    self.frame = (CGRect){CGPointMake(self.frame.origin.x, self.frame.origin.y - size.height), size};
    self.contentSize = self.frame.size;
}

- (void)initSubviewsWithData:(NSArray *)array
{
    _buttonArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        CGSize buttonSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - (kCountOfARow + 1) * kMarginW) / kCountOfARow, kButtonHeight);
        
        JSHLabelButton *button = [[JSHLabelButton alloc] initWithFrame:(CGRect){CGPointZero, buttonSize}];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectWithButton:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonLongPressed:)];
        [button addGestureRecognizer:longGesture];
        button.edit = NO;
        [self addSubview:button];
        [_buttonArray addObject:button];
    }
    [self refreshView];
}

- (void)refreshView
{
    [UIView animateWithDuration:kDuration animations:^{
        for (int i  = 0; i < _buttonArray.count; i++) {
            JSHLabelButton *button = _buttonArray[i];
            CGFloat buttonX = 0;
            CGFloat buttonY = 0;
            if (i == 0) {
                buttonX = kMarginW;
                buttonY = kMarginH;
            }else {
                JSHLabelButton *foreButton = _buttonArray[i - 1];
                buttonX = CGRectGetMaxX(foreButton.frame) + kMarginW;
                buttonY = foreButton.frame.origin.y;
                if (buttonX + button.bounds.size.width > [UIScreen mainScreen].bounds.size.width) {
                    buttonX = kMarginW;
                    buttonY = CGRectGetMaxY(foreButton.frame) + kMarginH;
                }
            }
            button.frame = (CGRect){CGPointMake(buttonX, buttonY), button.bounds.size};
        }
    }];

}

- (void)selectWithButton:(JSHLabelButton *)button
{
    if ([self.delegate respondsToSelector:@selector(didSelectedButton:)]) {
        [self.delegate didSelectedButton:button];
    }
}
#pragma mark Gesture Action
- (void)buttonLongPressed:(UILongPressGestureRecognizer *)sender
{
    JSHLabelButton *button = (JSHLabelButton *)sender.view;
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            [UIView animateWithDuration:kDuration animations:^{
                button.transform = CGAffineTransformMakeScale(1.1, 1.1);
                button.alpha = 0.7;
            }];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint newPoint = [sender locationInView:self];
            CGFloat Xdelta = newPoint.x - button.center.x;
            CGFloat Ydelta = newPoint.y - button.center.y;
//            NSLog(@"xdelta is %f, ydelta is %f", Xdelta, Ydelta);
            button.center = CGPointMake(button.center.x + Xdelta, button.center.y + Ydelta);
            //检测是否进入其他button区域
            NSInteger newIndex = [self indexOfButtonWithMovingButton:button];
            if (newIndex < 0) {
            
            }else {
                if (_placeHolder == nil) {
                    _placeHolder = [[JSHLabelButton alloc] initWithFrame:(CGRect){CGPointZero, CGSizeMake(([UIScreen mainScreen].bounds.size.width - (kCountOfARow + 1) * kMarginW) / kCountOfARow, kButtonHeight)}];
                    [_buttonArray removeObject:button];
                }else {
                    [_buttonArray removeObject:_placeHolder];
                }
                [_buttonArray insertObject:_placeHolder atIndex:newIndex];
                [self refreshView];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (_placeHolder != nil) {
                [_buttonArray replaceObjectAtIndex:[_buttonArray indexOfObject:_placeHolder] withObject:button];
                _placeHolder = nil;
            }
            button.transform = CGAffineTransformIdentity;
            button.alpha = 1;
            [self refreshView];
            
        }
            break;
        default:
            break;
    }
}

- (NSInteger)indexOfButtonWithMovingButton:(JSHLabelButton *)movingButton
{
    for (NSInteger i = 0;i<_buttonArray.count;i++)
    {
        JSHLabelButton *button = _buttonArray[i];
        if (button != movingButton)
        {
            if (CGRectContainsPoint(button.frame, movingButton.center))
            {
                return i;
            }
        }
    }
    return -1;
}

@end

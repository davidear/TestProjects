//
//  SAISegmentView.h
//  sai-iOS
//
//  Created by DaiFengyi on 15/10/21.
//  Copyright © 2015年 Malong Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SAISegment;
@protocol SAISegmentViewDelegate <NSObject>
- (void)segmentView:(nonnull SAISegment *)seg Select:(NSInteger)index;
@end
@interface SAISegment : UIView
@property (strong, nonatomic, nonnull) NSArray *items;
@property (weak, nonatomic) id<SAISegmentViewDelegate> delegate;
- (void)setTitle:(nullable NSString *)title forSegmentAtIndex:(NSUInteger)segment;
@end

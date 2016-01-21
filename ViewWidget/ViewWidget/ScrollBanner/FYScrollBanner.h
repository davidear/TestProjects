//
//  FYScrollBanner.h
//  
//
//  Created by dfy on 15/1/27.
//  Copyright (c) 2015年 childrenAreOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FYScrollBanner : UIView
@property (strong, nonatomic) NSMutableArray *imageList;

- (id)initWithFrame:(CGRect)frame index:(NSInteger)index;
@end

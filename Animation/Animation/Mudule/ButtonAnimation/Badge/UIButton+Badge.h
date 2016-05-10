//
//  UIButton+Badge.h
//  sai-iOS
//
//  Created by DaiFengyi on 15/12/17.
//  Copyright © 2015年 Malong Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Badge)
- (void)setBadgeWithNumber:(NSInteger)number;
- (void)setBadgeWithNumber:(NSInteger)number center:(CGPoint)center;
@end

//
//  SAI1PXLine.h
//  sai-iOS
//
//  Created by DaiFengyi on 15/12/31.
//  Copyright © 2015年 Malong Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAI1PXLine : UIImageView
/**
 * @brief 网格间距，默认30
 */
@property (nonatomic, assign) CGFloat   gridSpacing;
/**
 * @brief 网格线宽度，默认为1 pixel (1.0f / [UIScreen mainScreen].scale)
 */
@property (nonatomic, assign) CGFloat   gridLineWidth;
/**
 * @brief 网格颜色，默认蓝色
 */
@property (nonatomic, strong) UIColor   *gridColor;
@end

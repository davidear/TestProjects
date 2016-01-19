//
//  SAITailorView.h
//  sai-iOS
//
//  Created by DaiFengyi on 15/9/24.
//  Copyright © 2015年 Malong Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SAIiCardImage;
@interface SAITailorView : UIImageView
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic, readonly) UIImageView *imageView;
@end

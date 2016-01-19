//
//  SAITailorView.m
//  sai-iOS
//
//  Created by DaiFengyi on 15/9/24.
//  Copyright © 2015年 Malong Tech. All rights reserved.
//

#import "SAITailorView.h"
#import "UIImageView+WebCache.h"
// dtr
// static NSInteger count;
@interface SAITailorView ()
@end
@implementation SAITailorView 
- (instancetype)init {
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        self.userInteractionEnabled = NO;
        _imageView = [[UIImageView alloc] init];
//        _imageView.backgroundColor = [UIColor grayColor];
//        _imageView.image = [UIImage imageNamed:@"ai_white_ph"];
        self.image = [UIImage imageNamed:@"ai_gray_ph"];
        self.contentMode = UIViewContentModeCenter;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1;
        [self addSubview:_imageView];
    }
    return self;
}
- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    __weak typeof(self) weakSelf = self;
    // dtc it calls layoutsubviews, should it nacessary?
//    _imageView.frame = CGRectZero;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]
        placeholderImage:nil
        options: SDWebImageRetryFailed | SDWebImageLowPriority
        progress:^(NSInteger receivedSize, NSInteger expectedSize) {

        }
        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // dtc if the return image not draw in the right way , call the layoutsubview
            dispatch_async(dispatch_get_main_queue(), ^{
//                    [weakSelf setNeedsLayout];
//                    [weakSelf layoutIfNeeded];
                NSLog(@"\nimageView is %@,\n imageView.image is %@, image is %@", weakSelf.imageView, weakSelf.imageView.image, image);
            });
        }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews {
    // dtr
    //    count++;

    //    DDLogDebug(@"count is %d", count);
    // dtd to avoid crash when the data from API with null width or height
    CGRect resizeRect = [self caculateWithContainerSize:self.bounds.size
                                              imageSize:CGSizeMake(1000, 704)
                                             focusPoint:CGPointMake(1000 / 2, 704 / 2)];
    //    DDLogDebug(@"\ncontainerSize: %@\nimageSize: %@\nfocusPoint: %@\n计算结果: %@",
    //    NSStringFromCGSize(self.bounds.size),
    //          NSStringFromCGSize(CGSizeMake(self.icardImage.width.floatValue, self.icardImage.height.floatValue)),
    //          NSStringFromCGPoint(CGPointMake(self.icardImage.width.floatValue / 2, self.icardImage.height.floatValue
    //          / 2)),
    //          NSStringFromCGRect(resizeRect));
    _imageView.frame = resizeRect;
}

- (CGRect)caculateWithContainerSize:(CGSize)containerSize imageSize:(CGSize)imageSize focusPoint:(CGPoint)focusPoint {
    CGRect result = CGRectZero;
    CGPoint resultFocusPoint;
    CGFloat widthRate = containerSize.width / imageSize.width;
    CGFloat heightRate = containerSize.height / imageSize.height;
    //    CGFloat rate = MIN(widthRate, heightRate);
    if (widthRate >= heightRate) {
        result.size = CGSizeMake(imageSize.width * widthRate, imageSize.height * widthRate);
        resultFocusPoint = CGPointMake(focusPoint.x * widthRate, focusPoint.y * heightRate);
        // move the y
        CGFloat deltaY = containerSize.height / 2 - resultFocusPoint.y;
        CGFloat deltaImageY = containerSize.height - result.size.height;
        if (deltaY >= 0) {
            result.origin.y = MIN(deltaY, deltaImageY);
        } else {
            result.origin.y = MAX(deltaY, deltaImageY);
        }
    } else {
        result.size = CGSizeMake(imageSize.width * heightRate, imageSize.height * heightRate);
        resultFocusPoint = CGPointMake(focusPoint.x * heightRate, focusPoint.y * heightRate);
        // move the x
        CGFloat deltaX = containerSize.width / 2 - resultFocusPoint.x;
        CGFloat deltaImageX = containerSize.width - result.size.width;
        if (deltaX >= 0) {
            result.origin.x = MIN(deltaX, deltaImageX);
        } else {
            result.origin.x = MAX(deltaX, deltaImageX);
        }
    }
    return result;
}
@end

//
//  DFYCollectionViewCell.m
//  collectionView
//
//  Created by dfy on 15/2/11.
//  Copyright (c) 2015年 childrenAreOurFuture. All rights reserved.
//

#import "DFYCollectionViewCell.h"

@implementation DFYCollectionViewCell
{
    IBOutlet UILabel *label;
}

- (void)setLabelText:(NSString *)labelText
{
    _labelText = labelText;
    label.text = _labelText;
}
- (void)awakeFromNib {
    // Initialization code
}

@end

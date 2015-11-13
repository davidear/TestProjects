//
//  SAIiCardImage+CoreDataProperties.h
//  MagicalRecordDemo
//
//  Created by DaiFengyi on 15/11/4.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SAIiCardImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface SAIiCardImage (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *height;
@property (nullable, nonatomic, retain) NSNumber *width;
@property (nullable, nonatomic, retain) SAIBaseiCard *iCard;
@property (nullable, nonatomic, retain) SAISlideiCard *results;

@end

NS_ASSUME_NONNULL_END

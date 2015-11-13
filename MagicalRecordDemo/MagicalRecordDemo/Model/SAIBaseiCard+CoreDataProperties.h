//
//  SAIBaseiCard+CoreDataProperties.h
//  MagicalRecordDemo
//
//  Created by DaiFengyi on 15/11/4.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SAIBaseiCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface SAIBaseiCard (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *cardNote;
@property (nullable, nonatomic, retain) SAIiCardImage *iCardImage;

@end

NS_ASSUME_NONNULL_END

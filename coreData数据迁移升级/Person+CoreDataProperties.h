//
//  Person+CoreDataProperties.h
//  coreData数据迁移升级
//
//  Created by DaiFengyi on 15/12/14.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *lastname;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *firstname;
@property (nullable, nonatomic, retain) TSClass *myClass;

@end

NS_ASSUME_NONNULL_END

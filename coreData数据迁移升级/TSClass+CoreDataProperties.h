//
//  TSClass+CoreDataProperties.h
//  coreData数据迁移升级
//
//  Created by DaiFengyi on 15/12/14.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TSClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSClass (CoreDataProperties)

@property (nullable, nonatomic, retain) NSSet<Person *> *students;

@end

@interface TSClass (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(Person *)value;
- (void)removeStudentsObject:(Person *)value;
- (void)addStudents:(NSSet<Person *> *)values;
- (void)removeStudents:(NSSet<Person *> *)values;

@end

NS_ASSUME_NONNULL_END

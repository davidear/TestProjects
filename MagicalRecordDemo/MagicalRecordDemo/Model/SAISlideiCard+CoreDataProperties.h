//
//  SAISlideiCard+CoreDataProperties.h
//  MagicalRecordDemo
//
//  Created by DaiFengyi on 15/11/4.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SAISlideiCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface SAISlideiCard (CoreDataProperties)

@property (nullable, nonatomic, retain) NSOrderedSet<SAIiCardImage *> *results;

@end

@interface SAISlideiCard (CoreDataGeneratedAccessors)

- (void)insertObject:(SAIiCardImage *)value inResultsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromResultsAtIndex:(NSUInteger)idx;
- (void)insertResults:(NSArray<SAIiCardImage *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeResultsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInResultsAtIndex:(NSUInteger)idx withObject:(SAIiCardImage *)value;
- (void)replaceResultsAtIndexes:(NSIndexSet *)indexes withResults:(NSArray<SAIiCardImage *> *)values;
- (void)addResultsObject:(SAIiCardImage *)value;
- (void)removeResultsObject:(SAIiCardImage *)value;
- (void)addResults:(NSOrderedSet<SAIiCardImage *> *)values;
- (void)removeResults:(NSOrderedSet<SAIiCardImage *> *)values;

@end

NS_ASSUME_NONNULL_END

//
//  SAISlideiCard+CoreDataProperties.m
//  MagicalRecordDemo
//
//  Created by DaiFengyi on 15/11/4.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SAISlideiCard+CoreDataProperties.h"

@implementation SAISlideiCard (CoreDataProperties)

@dynamic results;
- (void)addResultsObject:(SAIiCardImage *)value {
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.results];
    [tempSet addObject:value];
    self.results = tempSet;
}
@end

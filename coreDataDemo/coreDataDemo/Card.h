//
//  Card.h
//  coreDataDemo
//
//  Created by dai.fengyi on 15/6/17.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Card : NSManagedObject

@property (nonatomic, retain) NSString * no;
@property (nonatomic, retain) NSManagedObject *person;

@end

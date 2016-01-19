//
//  MasterViewController.h
//  PassingThoughts
//
//  Created by Scott Gardner on 12/13/12.
//  Copyright (c) 2012 Scott Gardner. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

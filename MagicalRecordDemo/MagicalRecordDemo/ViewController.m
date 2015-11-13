//
//  ViewController.m
//  MagicalRecordDemo
//
//  Created by DaiFengyi on 15/11/2.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//

#import "ViewController.h"
#import "SAISlideiCard.h"
#import "MagicalRecord.h"
#import "SAIiCardImage.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}
- (IBAction)save:(UIButton *)sender {
    SAISlideiCard *iCard = [SAISlideiCard MR_createEntity];
    SAIiCardImage *ii = [SAIiCardImage MR_createEntity];
    ii.width = @3;
    ii.height = @5;
    ii.iCard = iCard;
    
    SAIiCardImage *i1 = [SAIiCardImage MR_createEntity];
    ii.width = @8;
    i1.height = @9;
    i1.iCard = iCard;
    [iCard addResultsObject:i1];
    
    SAIiCardImage *i2 = [SAIiCardImage MR_createEntity];
    i2.width = @15;
    i2.height = @25;
    i2.iCard = iCard;
    [iCard addResultsObject:i2];
    
    SAIiCardImage *i3 = [SAIiCardImage MR_createEntity];
    i3.width = @66;
    i3.height = @83;
    i3.iCard = iCard;

    [iCard addResultsObject:i3];
    
    iCard.cardNote = @"icardNote";
    
    
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
        NSLog(@"save successfully");
    }];
}


- (IBAction)buttonClick:(UIButton *)sender {
    NSArray *iCardArray = [SAISlideiCard MR_findAll];
    NSArray *iCardImagesArray = [SAIiCardImage MR_findAll];
    
    NSLog(@"\niCardsArray is %@\n\n,iCardImagesArray is %@\n", iCardArray, iCardImagesArray);
}
- (IBAction)shanchu:(id)sender {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
    //        [localContext MR_saveToPersistentStoreWithCompletion:nil];
    
            NSMutableArray *array = [NSMutableArray arrayWithArray:[SAIiCardImage MR_findAllInContext:localContext]];
            [array removeLastObject];
            NSLog(@"it saved successfully");
    
    
        } completion:^(BOOL contextDidSave, NSError *error) {
            
        }];
}


@end

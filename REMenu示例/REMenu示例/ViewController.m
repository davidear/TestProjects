//
//  ViewController.m
//  REMenu示例
//
//  Created by DaiFengyi on 15/11/9.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//

#import "ViewController.h"
#import "REMenu.h"
#import "REMenuItemView.h"
#import "SAISegment.h"
@interface ViewController ()<SAISegmentViewDelegate>
@property (weak, nonatomic) IBOutlet SAISegment *segmentView;
@property (strong, nonatomic) REMenu *menu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.segmentView.items = @[@"左侧", @"右侧"];
    self.segmentView.delegate = self;
    
    [REMenuItem alloc] initwith
    REMenuItem *homeItem = [[REMenuItem alloc] initWithTitle:@"Home"
                                                    subtitle:@"Return to Home Screen"
                                                       image:[UIImage imageNamed:@"Icon_Home"]
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          NSLog(@"Item: %@", item);
                                                      }];
    
    REMenuItem *exploreItem = [[REMenuItem alloc] initWithTitle:@"Explore"
                                                       subtitle:@"Explore 47 additional options"
                                                          image:[UIImage imageNamed:@"Icon_Explore"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                         }];
    
    REMenuItem *activityItem = [[REMenuItem alloc] initWithTitle:@"Activity"
                                                        subtitle:@"Perform 3 additional activities"
                                                           image:[UIImage imageNamed:@"Icon_Activity"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              NSLog(@"Item: %@", item);
                                                          }];
    
    REMenuItem *profileItem = [[REMenuItem alloc] initWithTitle:@"Profile"
                                                          image:[UIImage imageNamed:@"Icon_Profile"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                         }];
    
    self.menu = [[REMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem, profileItem]];
    self.menu.itemHeight = 30;

}

- (void)segmentView:(SAISegment *)seg Select:(NSInteger)index {
    if (index == -1) {
        [self.menu close];
    }else {
        [self.menu closeWithCompletion:^{
    [self.menu showFromRect:CGRectMake(0, 44, self.segmentView.bounds.size.width, 44*5) inView:self.self.segmentView];
        }];
    }
}


@end

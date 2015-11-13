//
//  ViewController.m
//  UIImageKeyedArchive
//
//  Created by DaiFengyi on 15/10/28.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//

#import "ViewController.h"
#define SAIDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] //  document目录
#define kResultList @"kResultList.archive"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [SAIDocument stringByAppendingPathComponent:kResultList];

    UIImage *image = [UIImage imageNamed:@"avatar_ph_72"];
    BOOL saveSuccess = [NSKeyedArchiver archiveRootObject:image toFile:path];
    NSLog(@"save result is %d\n\n\n", saveSuccess);
    
    UIImage *new = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"new is %@", new);
    
    
//    [UIImage imageWithData:<#(nonnull NSData *)#> scale:<#(CGFloat)#>]
//    NSData *data = UIImageJPEGRepresentation(image, 0.5);
//    NSLog(@"data.size is %ld", data.length);
//    
//    UIImage *image2 = [UIImage imageWithData:data];
//    NSData *data1 = UIImageJPEGRepresentation(image2, 1);
//    NSLog(@"data1.size is %ld", data1.length);
}

@end

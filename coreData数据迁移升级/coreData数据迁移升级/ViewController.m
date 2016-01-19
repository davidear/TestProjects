//
//  ViewController.m
//  coreData数据迁移升级
//
//  Created by DaiFengyi on 15/12/14.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "TSClass.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController {
    NSManagedObjectContext *_context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initDB];
}

- (void)initDB
{
    // 1. 实例化持久化的存储
    // 1.1 从Bundle中加载被管理的数据模型
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    // 1.2 实例化持久化存储调度
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    // 1.3 添加持久化存储(SQLite)
    NSError *error = nil;
    NSString *urlStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [urlStr stringByAppendingPathComponent:@"my.db"];
        NSURL *url = [NSURL fileURLWithPath:path];
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    
    if (store == nil) {
        [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
    }
    
    // 管理对象上下文
    _context = [[NSManagedObjectContext alloc] init];
    _context.persistentStoreCoordinator = psc;
}

- (IBAction)addData:(UIButton *)sender {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:_context];
    Person *person = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:_context];
    person.lastname = @"dai";
    person.firstname = @"fengyi";
    person.age = @18;
    //    person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:_context];
    
    if ([_context save:nil]) {
        NSLog(@"save success");
    }else {
        NSLog(@"save failure");
    }
}
@end

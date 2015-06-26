//
//  ViewController.m
//  coreDataDemo
//
//  Created by dai.fengyi on 15/6/11.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Person.h"
#import "Card.h"

@interface ViewController ()<NSCoding>

@end

@implementation ViewController
{
    NSManagedObjectContext *_context;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initDB];
//    [self initTableInDB];

    [self updatePerson];
    [self lookTableInDB];
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

- (void)initTableInDB
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:_context];
    Person *person = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:_context];
    person.name = @"david";
    person.age = @18;
//    person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:_context];
    
    if ([_context save:nil]) {
        NSLog(@"save success");
    }else {
        NSLog(@"save failure");
    }
}

- (void)lookTableInDB
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    
    NSArray *array = [_context executeFetchRequest:request error:nil];
    
    for (Person *person in array) {
        NSLog(@"person %@ %@ %@", person.name, person.age, person.card);
    }
    
}

- (void)updatePerson
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
//    request.predicate = [NSPredicate predicateWithFormat:@"author CONTAINS ''"];
    request.fetchLimit = 2;
    NSArray *array = [_context executeFetchRequest:request error:nil];
    for (Person *person in array) {
        person.name = @"Tom";
        person.age = @15;
    }
    
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    
//    //1.搭建上下文环境
//    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
//    
//    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
//    
//    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    
//    NSURL *url = [NSURL URLWithString:[docs stringByAppendingPathComponent:@"person.data"]];
//    
//    NSError *error = nil;
//    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
//    if (store == nil) {
//        [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
//    }
//    
//    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
//    context.persistentStoreCoordinator = psc;
//    
//    //2.添加数据到数据库
//    NSManagedObject *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
//    
//    [person setValue:@"david" forKey:@"name"];
//    [person setValue:[NSNumber numberWithInt:29] forKey:@"age"];
//    
//    NSManagedObject *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
//    [card setValue:@"88688" forKey:@"no"];
//    
//    [person setValue:card forKey:@"card"];
//    
//    NSError *error2 = nil;
//    BOOL success = [context save:&error];
//    if (!success) {
//        [NSException raise:@"访问数据库错误" format:@"%@", [error2 localizedDescription]];
//    }
//    
//    NSFetchRequest * request = [[NSFetchRequest alloc] init];
//    
//    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
//    
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
//    request.sortDescriptors = [NSArray arrayWithObject:sort];
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", @"*Itcast-1*"];
//    request.predicate = predicate;
//    
//    NSError *error3 = nil;
//    NSArray *objs = [context executeFetchRequest:request error:&error];
//    
//    if (error) {
//        [NSException raise:@"查询错误" format:@"%@", [error3 localizedDescription]];
//    }
//    
//    for (NSManagedObject *obj in objs) {
//        NSLog(@"name = %@", [obj valueForKey:@"name"]);
//    }
//}
//
//- (void)searchData
//{
//    //1.搭建上下文环境
//    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
//    
//    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
//    
//    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
//    context.persistentStoreCoordinator = psc;
//    // 初始化一个查询请求
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    // 设置要查询的实体
//    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
//    // 设置排序（按照age降序）
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
//    request.sortDescriptors = [NSArray arrayWithObject:sort];
//    // 设置条件过滤(搜索name中包含字符串"Itcast-1"的记录，注意：设置条件过滤时，数据库SQL语句中的%要用*来代替，所以%Itcast-1%应该写成*Itcast-1*)
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", @"*Itcast-1*"];
//    request.predicate = predicate;
//    // 执行请求
//    NSError *error = nil;
//    NSArray *objs = [context executeFetchRequest:request error:&error];
//    if (error) {
//        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
//    }
//    // 遍历数据
//    for (NSManagedObject *obj in objs) {
//        NSLog(@"name=%@", [obj valueForKey:@"name"]);
//    }
//}



@end

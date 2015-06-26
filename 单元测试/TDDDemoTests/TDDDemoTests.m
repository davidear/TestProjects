//
//  TDDDemoTests.m
//  TDDDemoTests
//
//  Created by dai.fengyi on 15/6/4.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ViewController.h"
@interface TDDDemoTests : XCTestCase

@end

@implementation TDDDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testViewControllerExist {
    XCTAssertNotNil([ViewController class], @"ViewController class should exist");
}

- (void)testViewControllerObjectCanBeCreated {
    ViewController *vc = [[ViewController alloc] init];
    XCTAssertNotNil(vc, @"ViewController object can be created");
}

- (void)testPushANumberAndGetIt {
    ViewController *stack = [ViewController new];
    [stack push:2.3];
    double topNumber = [stack top];
    XCTAssertEqual(topNumber, 2.3, @"VVStack should can be pushed and has that top value.");
}


- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

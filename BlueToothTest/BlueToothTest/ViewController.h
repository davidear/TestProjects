//
//  ViewController.h
//  BlueToothTest
//
//  Created by dai.fy on 15/4/15.
//  Copyright (c) 2015年 dai.fy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol BTdelegate
@optional
- (void)DidNotifyFailConnectService:(CBService *)service withPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;

@end
@interface ViewController : UIViewController

@property (weak, nonatomic) id<BTdelegate> delegate;
@end


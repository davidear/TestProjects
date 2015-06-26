//
//  ViewController.m
//  BlueToothTest
//
//  Created by dai.fy on 15/4/15.
//  Copyright (c) 2015年 dai.fy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CBCentralManagerDelegate, CBPeripheralDelegate>
{
    CBCentralManager *manager;
    CBPeripheral *_testPeripheral;
    NSMutableArray *_dicoveredPeripherals;
    NSTimer *connectTimer;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1 init manager
    manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    //2 scan the devices
    [manager scanForPeripheralsWithServices:nil options:nil];
}


- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    
    if(![_dicoveredPeripherals containsObject:peripheral])
        [_dicoveredPeripherals addObject:peripheral];
    
    NSLog(@"dicoveredPeripherals:%@", _dicoveredPeripherals);
}

//连接指定的设备
-(BOOL)connect:(CBPeripheral *)peripheral
{
    NSLog(@"connect start");
    _testPeripheral = nil;
    
    [manager connectPeripheral:peripheral
                       options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
    
    //开一个定时器监控连接超时的情况
    connectTimer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(connectTimeout:) userInfo:peripheral repeats:NO];
    
    return (YES);
}


- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    [connectTimer invalidate];//停止时钟
    
    NSLog(@"Did connect to peripheral: %@", peripheral);
    _testPeripheral = peripheral;
    
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
    
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    
    
    NSLog(@"didDiscoverServices");
    
    if (error)
    {
        NSLog(@"Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        
//        if ([self.delegate respondsToSelector:@selector(DidNotifyFailConnectService:withPeripheral:error:)])
//            [self.delegate DidNotifyFailConnectService:nil withPeripheral:nil error:nil];
        
        return;
    }
    
    
    for (CBService *service in peripheral.services)
    {
        
//        if ([service.UUID isEqual:[CBUUID UUIDWithString:UUIDSTR_ISSC_PROPRIETARY_SERVICE]])
//        {
//            NSLog(@"Service found with UUID: %@", service.UUID);
//            [peripheral discoverCharacteristics:nil forService:service];
//            isVPOS3356 = YES;
//            break;
//        }
        
        
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    
    if (error)
    {
        NSLog(@"Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        
//        if ([self.delegate respondsToSelector:@selector(DidNotifyFailConnectChar:withPeripheral:error:)])
//            [self.delegate DidNotifyFailConnectChar:nil withPeripheral:nil error:nil];
        
        return;
    }
    
    
    for (CBCharacteristic *characteristic in service.characteristics)
    {
//        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUIDSTR_ISSC_TRANS_TX]])
//        {
//            NSLog(@"Discovered read characteristics:%@ for service: %@", characteristic.UUID, service.UUID);
//            
//            _readCharacteristic = characteristic;//保存读的特征
//            
//            if ([self.delegate respondsToSelector:@selector(DidFoundReadChar:)])
//                [self.delegate DidFoundReadChar:characteristic];
//            
//            break;
//        }
    }
    
    
    for (CBCharacteristic * characteristic in service.characteristics)
    {
        
        
//        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUIDSTR_ISSC_TRANS_RX]])
//        {
//            
//            NSLog(@"Discovered write characteristics:%@ for service: %@", characteristic.UUID, service.UUID);
//            _writeCharacteristic = characteristic;//保存写的特征
//            
//            if ([self.delegate respondsToSelector:@selector(DidFoundWriteChar:)])
//                [self.delegate DidFoundWriteChar:characteristic];
//            
//            break;
//            
//            
//        }
    }
    
//    if ([self.delegate respondsToSelector:@selector(DidFoundCharacteristic:withPeripheral:error:)])
//        [self.delegate DidFoundCharacteristic:nil withPeripheral:nil error:nil];
    
}

@end

//
//  ViewController.m
//  TouchLock
//
//  Created by dai.fy on 15/4/30.
//  Copyright (c) 2015年 dai.fy. All rights reserved.
//

#import "ViewController.h"
#import "SSKeychain.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accoutField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)setPassword:(id)sender {
    BOOL success = [SSKeychain setPassword:self.passwordField.text forService:@"TouchLock" account:self.accoutField.text];
    [[NSUserDefaults standardUserDefaults] setObject:self.accoutField.text forKey:@"account"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:self.switchButton.isOn] forKey:@"zwsb"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"%d",success);
}


@end

//
//  ViewController.m
//  ImagePickerControllerCustomizationDemo
//
//  Created by DaiFengyi on 15/12/4.
//  Copyright © 2015年 DaiFengyi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)takePhoto:(UIButton *)sender {
    [self tackPhotoHandler:YES];
}

- (void)tackPhotoHandler:(BOOL)isTryCamera {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if (isTryCamera && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = YES;
    }
    imagePicker.delegate = self;
    imagePicker.showsCameraControls = NO;
    imagePicker.cameraViewTransform = CGAffineTransformMakeScale(2, 2);
    imagePicker.allowsEditing = YES;
    imagePicker.cameraOverlayView = [[[NSBundle mainBundle] loadNibNamed:@"CameraOverlayView" owner:self options:nil] lastObject];
//    imagePicker.cameraOverlayView.frame = CGRectMake(0, 300, 320, 200);
    
    
    
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 1. get image
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    NSLog(@"success");
}
@end

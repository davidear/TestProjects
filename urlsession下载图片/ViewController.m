//
//  ViewController.m
//  OnlyForTest
//
//  Created by dai.fy on 15/4/25.
//  Copyright (c) 2015年 dai.fy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDelegate,NSURLSessionDownloadDelegate,NSURLSessionTaskDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURLSessionConfiguration *aConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:aConfiguration delegate:self delegateQueue:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/5a21bjqh_Q23odCf/static/superplus/img/spis7_f80cc562.png"]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        dispatch_queue_t queue =  dispatch_get_main_queue();
        dispatch_async(queue, ^{
            NSData *data = [NSData dataWithContentsOfURL:location];
            UIImage *image = [UIImage imageWithData:data];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.contentMode = UIViewContentModeCenter;
            [imageView setFrame:self.view.bounds];
            [self.view addSubview:imageView];
            NSLog(@"it comes");
        });
        
    }];
    
//    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    [task resume];
    [session flushWithCompletionHandler:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    NSLog(@"it's coming");
}

#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"did write : %lld, had writen : %lld, expect to write : %lld", bytesWritten , totalBytesWritten, totalBytesExpectedToWrite);
}
@end

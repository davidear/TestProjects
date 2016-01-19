//
//  DetailViewController.m
//  PassingThoughts
//
//  Created by Scott Gardner on 12/13/12.
//  Copyright (c) 2012 Scott Gardner. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *whenLabel;
@property (weak, nonatomic) IBOutlet UITextField *whereTextField;
@property (weak, nonatomic) IBOutlet UITextView *whatTextView;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        
        // 1
        NSDate *date = [self.detailItem valueForKey:@"when"];
        self.whenLabel.text = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
        
        // 2
        self.whereTextField.text = [self.detailItem valueForKey:@"where"];
        self.whatTextView.text = [self.detailItem valueForKey:@"what"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    // 1
    [self.whatTextView becomeFirstResponder];
    
    // 2
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self saveContext];
}

#pragma mark - Private methods

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self.detailItem managedObjectContext];
    
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - UITextFieldDelegate

// 1
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// 2
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:self.whereTextField]) {
        [self.detailItem setValue:textField.text forKey:@"where"];
    }
}

#pragma mark - UITextViewDelegate

// 3
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView isEqual:self.whatTextView]) {
        [self.detailItem setValue:textView.text forKey:@"what"];
    }
}

@end

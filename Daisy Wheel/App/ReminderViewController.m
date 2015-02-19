//
//  ReminderTableViewController.m
//  Daisy Wheel
//
//  Created by Phil Wright on 2/4/15.
//  Copyright (c) 2015 Phil Wright. All rights reserved.
//

#import "ReminderViewController.h"

@interface ReminderViewController ()

@end

@implementation ReminderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    HSDatePickerViewController *hsdpvc = [HSDatePickerViewController new];
    hsdpvc.delegate = self;
    [self presentViewController:hsdpvc animated:YES completion:nil];
}

#pragma mark - HSDatePicker Delegate methods

- (void)hsDatePickerPickedDate:(NSDate *)date
{
    NSLog(@"date: %@",date);
}

- (void)hsDatePickerWillDismissWithQuitMethod:(HSDatePickerQuitMethod)method
{
    
}

- (void)hsDatePickerDidDismissWithQuitMethod:(HSDatePickerQuitMethod)method
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end

//
//  MainViewController.m
//  PopupDatePicker
//
//  Created by Brennan Cleveland on 12/8/11.
//  Copyright (c) 2011 Livefront. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"
#import "PopupDatePicker.h"
#import "PopupDatePickerDelegate.h"
#import "PreferencesViewController.h"
#import "Constants.h"

@implementation MainViewController

@synthesize dateLabel = _dateLabel;
@synthesize popupDatePicker = _popupDatePicker;
@synthesize preferencesButton = _preferencesButton;

- (void) dealloc
{
    [_dateLabel release];
    [_popupDatePicker release];
    [_preferencesButton release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _popupDatePicker = [[PopupDatePicker alloc] init];
    self.popupDatePicker.delegate = self;
    self.dateLabel.layer.cornerRadius = 10.0f;
    self.dateLabel.layer.masksToBounds = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.dateLabel = nil;
    self.popupDatePicker = nil;
    self.preferencesButton = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *animationDuration = [defaults objectForKey:kAnimationDuration];
    NSNumber *animationDelay = [defaults objectForKey:kAnimationDelay];
    
    self.popupDatePicker.animationDuration = [animationDuration floatValue];
    self.popupDatePicker.animationDelay = [animationDelay floatValue];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark PopupDatePicker delegate methods

- (void) popupDatePickerWillShow: (PopupDatePicker *) datePicker animated: (BOOL) animated
{
    NSLog(@"will show");
}

- (void) popupDatePickerDidShow:(PopupDatePicker *) datePicker animated :(BOOL)animated
{
    NSNumber *clearDateOnShow = [[NSUserDefaults standardUserDefaults] objectForKey:kClearDateOnShow];
    if ([clearDateOnShow boolValue] == YES) {
        self.dateLabel.text = nil;
    }
}

- (void) popupDatePickerWillHide:(PopupDatePicker *) datePicker animated: (BOOL) animated
{
    NSLog(@"will hide");
}

- (void) popupDatePickerDidHide: (PopupDatePicker *) datePicker animated: (BOOL) animated
{
    NSNumber *showDateOnHide = [[NSUserDefaults standardUserDefaults] objectForKey:kShowDateOnHide];
    
    if ([showDateOnHide boolValue] == YES) {
        self.dateLabel.text = [datePicker.date description];
    }
}

- (void) popupDatePicker: (PopupDatePicker *) datePicker didSelectDate:(NSDate *)date
{
    NSNumber *showDateOnHide = [[NSUserDefaults standardUserDefaults] objectForKey:kShowDateOnHide];
    
    if ([showDateOnHide boolValue] == NO) {
        self.dateLabel.text = [date description];
    }
}

#pragma mark IBActions

- (IBAction)showDatePicker:(id)sender
{
    [self.popupDatePicker showFromView:self.view];
}

- (IBAction) didSelectPreferences:(id)sender
{
    PreferencesViewController *preferences = [[PreferencesViewController alloc] initWithNibName:@"PreferencesViewController" bundle:nil];
    [self presentModalViewController:preferences animated:YES];
    [preferences release];
}
@end

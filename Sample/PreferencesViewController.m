//
//  PreferencesViewController.m
//  PopupDatePicker
//
//  Created by Brennan Cleveland on 12/10/11.
//  Copyright (c) 2011 Livefront. All rights reserved.
//

#import "PreferencesViewController.h"
#import "Constants.h"

@implementation PreferencesViewController

@synthesize tableView = _tableView;
@synthesize durationLabel = _durationLabel;
@synthesize durationSlider = _durationSlider;
@synthesize delaySlider = _delaySlider;
@synthesize delayLabel = _delayLabel;

- (void) dealloc
{
    [_tableView release];
    [_durationSlider release];
    [_delaySlider release];
    [_durationLabel release];
    [_delayLabel release];
    [_animationDelayCell release];
    [_animationDurationCell release];
    [_tableViewCells release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _tableViewCells = [[NSMutableArray alloc] init];
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
    
    NSMutableArray *delegateSection = [NSMutableArray array];
    
    NSNumber *clearOnShow = [[NSUserDefaults standardUserDefaults] objectForKey:kClearDateOnShow];
    NSNumber *showOnHide = [[NSUserDefaults standardUserDefaults] objectForKey:kShowDateOnHide];
    
    UITableViewCell *showCell = [[UITableViewCell alloc] init];
    showCell.textLabel.text = @"Update date on hide";
    showCell.selectionStyle = UITableViewCellSelectionStyleNone;
    UISwitch *showOnHideSwitch = [[UISwitch alloc] init];
    showOnHideSwitch.on = [showOnHide boolValue];
    [showOnHideSwitch addTarget:self action:@selector(didToggleShowOnHide:) forControlEvents:UIControlEventValueChanged];
    showCell.accessoryView = showOnHideSwitch;
    [showOnHideSwitch release];
    [delegateSection addObject:showCell];
    [showCell release];
    
    UITableViewCell *hideCell = [[UITableViewCell alloc] init];
    hideCell.textLabel.text = @"Clear date on show";
     hideCell.selectionStyle = UITableViewCellSelectionStyleNone;
    UISwitch *clearOnShowSwitch = [[UISwitch alloc] init];
    [clearOnShowSwitch addTarget:self action:@selector(didToggleClearOnShow:) forControlEvents:UIControlEventValueChanged];
    clearOnShowSwitch.on = [clearOnShow boolValue];
    hideCell.accessoryView = clearOnShowSwitch;
    [clearOnShowSwitch release];
    [delegateSection addObject:hideCell];
    [hideCell release];
    
    [_tableViewCells addObject:delegateSection];
    
    NSMutableArray *animationSection = [NSMutableArray array];
    
    [animationSection addObject:_animationDurationCell];
    [animationSection addObject:_animationDelayCell];
    
    [_tableViewCells addObject:animationSection];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.tableView = nil;
    self.durationLabel = nil;
    self.delayLabel = nil;
    self.durationSlider = nil;
    self.delaySlider = nil;
    [_animationDelayCell release];
    [_animationDurationCell release];
    [_tableViewCells release];
}

- (void) viewWillAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *animationDuration = [defaults objectForKey:kAnimationDuration];
    NSNumber *animationDelay = [defaults objectForKey:kAnimationDelay];

    self.durationSlider.value = [animationDuration floatValue];
    self.durationLabel.text = [NSString stringWithFormat:@"%1.1f", [animationDuration floatValue]];
    self.delaySlider.value = [animationDelay floatValue];
    self.delayLabel.text = [NSString stringWithFormat:@"%1.1f", [animationDelay floatValue]];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark UITableView methods

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSArray *sectionArray = [_tableViewCells objectAtIndex:indexPath.section];
    return [sectionArray objectAtIndex:indexPath.row];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = [_tableViewCells objectAtIndex:section];
    return [sectionArray count];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Delegate Actions";
            break;
        case 1:
            return @"Animation";
            break;
        default:
            break;
    }
    
    return nil;
    
}

#pragma mark IBActions

- (IBAction) sliderValueChanged:(id)sender
{
    UISlider *slider = (UISlider *) sender;
    NSString *valueString = [NSString stringWithFormat:@"%1.1f", slider.value];
    UILabel *label = nil;
    NSString *preference = nil;
    
    if(sender == self.durationSlider) {
        preference = kAnimationDuration;
        label = self.durationLabel;
    }
    else {
        preference = kAnimationDelay;
        label = self.delayLabel;
    }

    label.text = valueString;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:slider.value] forKey:preference];
}

- (IBAction)didSelectDone:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) didToggleShowOnHide: (id) sender
{
    UISwitch *theSwitch = (UISwitch *) sender;
    NSNumber *updateOnHide = [NSNumber numberWithBool:theSwitch.on];
    [[NSUserDefaults standardUserDefaults] setObject:updateOnHide forKey:kShowDateOnHide];
}

- (void) didToggleClearOnShow: (id) sender
{
    UISwitch *theSwitch = (UISwitch *) sender;
    NSNumber *clearOnShow = [NSNumber numberWithBool:theSwitch.on];
    [[NSUserDefaults standardUserDefaults] setObject:clearOnShow forKey:kClearDateOnShow];
}
@end

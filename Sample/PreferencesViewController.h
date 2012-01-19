//
//  PreferencesViewController.h
//  PopupDatePicker
//
//  Created by Brennan Cleveland on 12/10/11.
//  Copyright (c) 2011 Livefront. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreferencesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
@private
    NSMutableArray *_tableViewCells;
    IBOutlet UITableViewCell *_animationDurationCell;
    IBOutlet UITableViewCell *_animationDelayCell;
}

@property (nonatomic, retain) IBOutlet UILabel *durationLabel;
@property (nonatomic, retain) IBOutlet UILabel *delayLabel;
@property (nonatomic, retain) IBOutlet UISlider *durationSlider;
@property (nonatomic, retain) IBOutlet UISlider *delaySlider;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (IBAction) sliderValueChanged:(id)sender;
- (IBAction) didSelectDone:(id)sender;
@end

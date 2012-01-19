//
//  MainViewController.h
//  PopupDatePicker
//
//  Created by Brennan Cleveland on 12/8/11.
//  Copyright (c) 2011 Livefront. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class PopupDatePicker;

@interface MainViewController : BaseViewController

@property (nonatomic, retain) IBOutlet PopupDatePicker *popupDatePicker;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UIButton *preferencesButton;

- (IBAction) showDatePicker:(id)sender;
- (IBAction) didSelectPreferences:(id)sender;
@end

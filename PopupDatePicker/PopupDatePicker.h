//
//  PopupDatePicker.h
//
//  Created by Brennan Cleveland on 11/14/11.
//  Copyright (c) 2011 Livefront. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupDatePickerDelegate.h"

/// Implements a date picker view that slides up and down
/// from the bottom of the device
///
@interface PopupDatePicker : UIView
{
    //Parent view of date picker and toolbar
    UIView * _dateView;
    UIView * _shadowView;
}

/// The date pickers delegate
@property (nonatomic, assign) id delegate;

/// The date picker view
@property (readonly) UIDatePicker *datePicker;

/// Done selecting date.  Causes picker to hide
@property (readonly) UIBarButtonItem *doneButton;

/// Toolbar for bar button items
@property (readonly) UIToolbar *toolbar;

/// The date selected
@property (assign) NSDate *date;

/// Animation duration
@property float animationDuration;

/// Delay before animating
@property float animationDelay;

/// Show the date picker using the specified view as the parent
///
- (void) showFromView: (UIView *) parentView;

/// Hide the date picker
///
- (void) hide;

@end

@interface PopupDatePicker (Private)

- (void) _didSelectDone;

@end

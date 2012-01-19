//
//  PopupDatePickerDelegate.h
//
//  Created by Brennan Cleveland on 12/8/11.
//  Copyright (c) 2011 Livefront. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PopupDatePicker;

/// Protocol to define methods invoked on a PopupDatePickerDelegate when it's displayed
/// or hidden and when a new date is selected.
///
@protocol PopupDatePickerDelegate <NSObject>

@optional

/// Invoked before the date picker is shown.
///
/// @param datePicker
///     The datePicker that will be shown.
///
/// @param animated
///     Indicates whether or not the transition will be animated.
///
- (void)popupDatePickerWillShow:(PopupDatePicker *)datePicker animated:(BOOL)animated;

/// Invoked after the date picker is shown.
///
/// @param datePicker
///     The datePicker that was shown.
///
/// @param animated
///     Indicates whether or not the transition was animated.
///
- (void)popupDatePickerDidShow:(PopupDatePicker *)datePicker animated:(BOOL)animated;

/// Invoked before the date picker is hidden.
///
/// @param datePicker
///     The datePicker that will be hidden.
///
/// @param animated
///     Indicates whether or not the transition will be animated.
///
- (void)popupDatePickerWillHide:(PopupDatePicker *)datePicker animated:(BOOL)animated;

/// Invoked after the date picker is hidden.
///
/// @param datePicker
///     The datePicker that was hidden.
///
/// @param animated
///     Indicates whether or not the transition was animated.
///
- (void)popupDatePickerDidHide:(PopupDatePicker *)datePicker animated:(BOOL)animated;

/// Invoked when a new date is selected.
///
/// @param datePicker
///     The datePicker.
///
/// @param date
///     The date that was selected.
///
- (void)popupDatePicker:(PopupDatePicker *)datePicker didSelectDate:(NSDate *)date;

@end


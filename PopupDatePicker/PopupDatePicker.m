//
//  PopupDatePicker.m
//
//  Created by Brennan Cleveland on 11/14/11.
//  Copyright (c) 2011 Livefront. All rights reserved.
//

#define __POPUP_DATE_PICKER_DEFAULT_ANIMATION_DURATION 0.3

#import "PopupDatePicker.h"

@implementation PopupDatePicker (Private)

- (void) _didSelectDone
{
    if ([self.delegate respondsToSelector:@selector(popupDatePicker:didSelectDate:)]) {
        [self.delegate popupDatePicker:self didSelectDate:self.datePicker.date];
    }
    [self hide];
}

@end

@implementation PopupDatePicker

@synthesize datePicker = _datePicker;
@synthesize doneButton = _doneButton;
@synthesize toolbar = _toolbar;
@synthesize date;
@synthesize animationDuration = _animationDuration;
@synthesize animationDelay = _animationDelay;
@synthesize delegate;

- (id)initWithFrame:(CGRect) parentFrame
{
    self = [super initWithFrame:parentFrame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _shadowView = [[UIView alloc] initWithFrame:parentFrame];
        _shadowView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        _shadowView.autoresizingMask = self.autoresizingMask;
        _animationDuration = __POPUP_DATE_PICKER_DEFAULT_ANIMATION_DURATION;
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.opaque = YES;
        [_datePicker addTarget:self action:@selector(dateDidChange) forControlEvents:UIControlEventValueChanged];

        _doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(_didSelectDone)];

        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, parentFrame.size.width, 44)];
        _toolbar.tintColor = [UIColor blackColor];
        _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        _toolbar.items = [NSArray arrayWithObjects: flexibleSpace, _doneButton, nil];

        CGRect frame = CGRectMake(0, 0, parentFrame.size.width, _datePicker.frame.size.height + _toolbar.frame.size.height);
        [flexibleSpace release];

        _dateView = [[UIView alloc] initWithFrame:frame];
        _dateView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_dateView addSubview:_toolbar];
        [_dateView addSubview:_datePicker];
        frame = _datePicker.frame;
        frame.origin.y = _toolbar.frame.origin.y + _toolbar.frame.size.height;
        _datePicker.frame = frame;
        for (UIView * subview in _datePicker.subviews) {
            subview.frame = _datePicker.bounds;
        }
        _shadowView.alpha = 0.0;

        [self addSubview:_shadowView];
        [self addSubview:_dateView];

        self.backgroundColor = [UIColor clearColor];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

- (id) init
{

    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    return [self initWithFrame:mainWindow.frame];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_datePicker release];
    [_dateView release];
    [_doneButton release];
    [_toolbar release];
    [_shadowView release];
    [super dealloc];
}

- (void) showFromView: (UIView *) parentView
{
    BOOL animated = _animationDuration > 0.0 ? YES : NO;
    self.frame = parentView.bounds;
    CGRect dateViewFrame = _dateView.frame;
    dateViewFrame.origin.y = self.frame.size.height;
    _dateView.frame = dateViewFrame;
    dateViewFrame.origin.y -= _dateView.frame.size.height;

    [parentView endEditing:YES];
    [parentView addSubview:self];

    if([delegate respondsToSelector:@selector(popupDatePickerWillShow:animated:)])
    {
        [delegate popupDatePickerWillShow:self animated:animated];
    }
    [UIView animateWithDuration:_animationDuration
                          delay:_animationDelay
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         _dateView.frame = dateViewFrame;
         _shadowView.alpha = 1.0;
     }
                     completion:^(BOOL finished)
     {
         if([delegate respondsToSelector:@selector(popupDatePickerDidShow:animated:)])
         {
             [delegate popupDatePickerDidShow:self animated:animated];
         }
     }
     ];
}

- (void) hide
{
    BOOL animated = _animationDuration > 0.0 ? YES : NO;
    CGRect dateViewFrame = _dateView.frame;
    dateViewFrame.origin.y = self.frame.size.height;

    if([delegate respondsToSelector:@selector(popupDatePickerWillHide:animated:)])
    {
        [delegate popupDatePickerWillHide:self animated:animated];
    }
    [UIView animateWithDuration:_animationDuration
                          delay:_animationDelay
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         _dateView.frame = dateViewFrame;
         _shadowView.alpha = 0.0;
     }
                     completion:^(BOOL finished)
     {
         [self removeFromSuperview];
         if([delegate respondsToSelector:@selector(popupDatePickerDidHide:animated:)])
         {
             [delegate popupDatePickerDidHide:self animated:animated];
         }
     }
     ];
}

- (NSDate *) date
{
    return self.datePicker.date;
}

- (void) setDate:(NSDate *) newDate
{
    self.datePicker.date = newDate;
}

- (void) setAnimationDuration:(float)animationDuration
{
    _animationDuration = animationDuration;
}

- (float) animationDuration
{
    return _animationDuration;
}

- (void) setAnimationDelay:(float)animationDelay
{
    _animationDelay = animationDelay;
}

- (float) animationDelay
{
    return _animationDelay;
}

- (void) orientationDidChange: (NSNotification *) notification
{

}

- (void)dateDidChange {
    if ([self.delegate respondsToSelector:@selector(popupDatePicker:didChangeDate:)]) {
        [self.delegate popupDatePicker:self didChangeDate:self.datePicker.date];
    }
}

@end

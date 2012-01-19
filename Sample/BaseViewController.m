//
//  BaseViewController.m
//  LivefrontSkeleton
//
//  Created by Brennan Cleveland on 12/10/11.
//  Copyright (c) 2011 Livefront. All rights reserved.
//

#import "BaseViewController.h"
#import "AboutLivefront.h"

@implementation BaseViewController

@synthesize contentView = _contentView;
@synthesize infoButton = _infoButton;

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
    _infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    CGRect frame = self.infoButton.frame;
    frame.origin.x = 282;
    frame.origin.y = 420;
    self.infoButton.frame = frame;
    [self.infoButton addTarget:self action:@selector(showInfo:) forControlEvents:UIControlEventTouchUpInside];
    self.infoButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    
    if(_contentView == nil) { 
        _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:self.contentView];
    }
    
    [self.contentView addSubview:self.infoButton];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark selectors

- (IBAction) showInfo: (id) sender
{
    AboutLivefront *about = [[AboutLivefront alloc] initWithNibName:@"AboutLivefront" bundle:nil];
    [self presentModalViewController:about animated:YES];
    [about release];
}

@end

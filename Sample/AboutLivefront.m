//
//  AboutLivefront.m
//  LivefrontSkeleton
//
//  Created by Brennan Cleveland on 12/10/11.
//  Copyright (c) 2011 Livefront. All rights reserved.
//

#import "AboutLivefront.h"

@implementation AboutLivefront

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    NSString *about = @"http://www.livefront.com";
    NSURL *aboutURL = [NSURL URLWithString:about];
    NSURLRequest *request = [NSURLRequest requestWithURL:aboutURL];
    [_aboutWebView loadRequest:request];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark UIWebView delegate methods

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

#pragma mark IBActions

- (IBAction) didSelectDone:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end

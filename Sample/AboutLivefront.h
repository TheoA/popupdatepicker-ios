//
//  AboutLivefront.h
//  LivefrontSkeleton
//
//  Created by Brennan Cleveland on 12/10/11.
//  Copyright (c) 2011 Livefront. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutLivefront : UIViewController <UIWebViewDelegate>
{
@private
    IBOutlet UIWebView *_aboutWebView;
}

- (IBAction) didSelectDone:(id)sender;
@end

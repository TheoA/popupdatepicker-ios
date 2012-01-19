//
//  AppDelegate.m
//  LivefrontSkeleton
//
//  Created by Brennan Cleveland on 12/9/11.
//  Copyright (c) 2011 Livefront. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "Constants.h"

@implementation AppDelegate

@synthesize window = _window;

+ (void) initialize
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *appDefaults = [NSMutableDictionary dictionary];
    
    [appDefaults setObject:[NSNumber numberWithBool: NO] forKey:kShowDateOnHide];
    [appDefaults setObject:[NSNumber numberWithBool: NO] forKey:kClearDateOnShow];
    [appDefaults setObject:[NSNumber numberWithFloat: 2.0f] forKey:kAnimationDuration];
    [appDefaults setObject:[NSNumber numberWithFloat: 0.0f] forKey:kAnimationDelay];
    
    [defaults registerDefaults: appDefaults];
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //Show the window
    [self.window makeKeyAndVisible];
    
    MainViewController *controller = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    self.window.rootViewController = controller;
    [controller release];
    
    //Add Livefront splash image
    _splash = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Default"]];
    _splash.frame = self.window.frame;
    [self.window addSubview:_splash];
    //remove the splash after 3 seconds.  
    [self performSelector:@selector(_removeSplash) withObject:nil afterDelay:3];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end

@implementation AppDelegate(Livefront)

- (void) _removeSplash
{
    //Get rid of the splash 
    [_splash removeFromSuperview];
    [_splash release];
}

@end

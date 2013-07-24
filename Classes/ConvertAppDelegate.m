//
//  ConvertAppDelegate.m
//  Convert
//
//  Created by Steve Baker on 1/5/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import "ConvertAppDelegate.h"
#import "ConvertViewController.h"
#import "GAI.h"

@interface ConvertAppDelegate ()
    @property(nonatomic, strong) GAI *googleAnalytics;
    @property(nonatomic, strong) id<GAITracker> googleAnalyticsTracker;
@end


@implementation ConvertAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // Google Analytics
    self.googleAnalytics = [GAI sharedInstance];
    // Optional: automatically send uncaught exceptions to Google Analytics.
    self.googleAnalytics.trackUncaughtExceptions = YES;
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    self.googleAnalytics.dispatchInterval = 20;
    // Optional: set debug to YES for extra debugging information.
    self.googleAnalytics.debug = YES;
    
    // Create tracker instance
    self.googleAnalyticsTracker = [self.googleAnalytics trackerWithTrackingId:@"UA-42678217-1"];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

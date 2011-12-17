//
//  ConvertAppDelegate.m
//  Convert
//
//  Created by Steve Baker on 1/5/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import "ConvertAppDelegate.h"
#import "ConvertViewController.h"

@implementation ConvertAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    self.viewController = nil;
    self.window = nil;
    [super dealloc];
}


@end

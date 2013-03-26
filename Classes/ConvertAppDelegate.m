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

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [self.window addSubview:self.viewController.view];
    [self.window makeKeyAndVisible];
}


#pragma mark - Application lifecycle

- (void)awakeFromNib
{
    // http://stackoverflow.com/questions/7520971/applications-are-expected-to-have-a-root-view-controller-at-the-end-of-applicati
    self.window.rootViewController = self.viewController;
}

@end

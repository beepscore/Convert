//
//  LogicTests.m
//  Convert
//
//  Created by Steve Baker on 6/23/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "LogicTests.h"


@implementation LogicTests

#if USE_APPLICATION_UNIT_TEST     // all code under test is in the iPhone Application

- (void) testAppDelegate
{
    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");    
}

#endif


@end

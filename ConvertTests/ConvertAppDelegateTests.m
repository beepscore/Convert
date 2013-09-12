//
//  ConvertAppDelegateTests.m
//  Convert
//
//  Created by Steve Baker on 7/28/13.
//  Copyright (c) 2013 Beepscore LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ConvertAppDelegate.h"
#import "ConvertAppDelegate_Private.h"

@interface ConvertAppDelegateTests : XCTestCase
@property ConvertAppDelegate *convertAppDelegate;
@end


@implementation ConvertAppDelegateTests

- (void) setUp
{
    self.convertAppDelegate = [[ConvertAppDelegate alloc] init];
    XCTAssertNotNil(self.convertAppDelegate, @"expected convertAppDelegate not nil");
}

- (void) tearDown
{
}


- (void) testAppDelegateApplicationDidFinishLaunchingWithOptions
{
    [self.convertAppDelegate application:nil
           didFinishLaunchingWithOptions:nil];
}

@end

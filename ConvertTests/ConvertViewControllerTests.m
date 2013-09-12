//
//  ConvertViewControllerTests.m
//  Convert
//
//  Created by Steve Baker on 7/28/13.
//  Copyright (c) 2013 Beepscore LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCMock.h"
#import "ConvertViewController.h"
#import "ConvertViewController_Private.h"
#import "GAITracker.h"

@interface ConvertViewControllerTests : XCTestCase
@property ConvertViewController *convertViewController;
@end


@implementation ConvertViewControllerTests

- (void) setUp
{
    self.convertViewController = [[ConvertViewController alloc] init];
    XCTAssertNotNil(self.convertViewController, @"Cannot create instance of ConvertViewController");
}

- (void) tearDown
{
}

- (void)testTrackUpdateTemperatures
{
    [self.convertViewController viewDidLoad];

    id mockAnalyticsTracker = [OCMockObject mockForProtocol:@protocol(GAITracker)];
    self.convertViewController.googleAnalyticsTracker = mockAnalyticsTracker;
    
    // initWithItems??
    UISegmentedControl *testSegmentedControl = [[UISegmentedControl alloc]
                                                initWithItems:@[@"w", @"x", @"y", @"z"]];
    NSInteger testSelectedSegmentIndex = 2;
    [testSegmentedControl setSelectedSegmentIndex:testSelectedSegmentIndex];
    self.convertViewController.fromTemperatureUnitSegment = testSegmentedControl;
    
    [[mockAnalyticsTracker expect] sendEventWithCategory:@"uiAction"
                                              withAction:@"updateTemperatures"
                                               withLabel:@"fromTemperatureUnitSegment"
                                               withValue:[NSNumber numberWithInt:testSelectedSegmentIndex]];

    [self.convertViewController trackUpdateTemperatures:self.convertViewController.fromTemperatureUnitSegment];
    
    // Verify all stubbed or expected methods were called.
    [mockAnalyticsTracker verify];
}

@end

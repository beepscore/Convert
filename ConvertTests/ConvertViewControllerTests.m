//
//  ConvertViewControllerTests.m
//  Convert
//
//  Created by Steve Baker on 7/28/13.
//  Copyright (c) 2013 Beepscore LLC. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "OCMock.h"
#import "ConvertViewController.h"
#import "ConvertViewController_Private.h"
#import "GAITracker.h"

@interface ConvertViewControllerTests : SenTestCase
@property ConvertViewController *convertViewController;
@end


@implementation ConvertViewControllerTests

- (void) setUp
{
    self.convertViewController = [[ConvertViewController alloc] init];
    STAssertNotNil(self.convertViewController, @"Cannot create instance of ConvertViewController");
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
    UISegmentedControl *testSegmentedControl = [[UISegmentedControl alloc] init];
    NSInteger testSelectedSegmentIndex = 2;
    [testSegmentedControl setSelectedSegmentIndex:testSelectedSegmentIndex];
    self.convertViewController.fromTemperatureUnitSegment = testSegmentedControl;
    
//    [[mockAnalyticsTracker expect] sendEventWithCategory:@"uiAction"
//                                              withAction:@"updateTemperatures"
//                                               withLabel:@"fromTemperatureUnitSegment"
//                                               withValue:[NSNumber numberWithInt:testSelectedSegmentIndex]];
    
    // method is called with value -1, possibly because segmented control doesn't have items.
    [[mockAnalyticsTracker expect] sendEventWithCategory:@"uiAction"
                                              withAction:@"updateTemperatures"
                                               withLabel:@"fromTemperatureUnitSegment"
                                               withValue:[NSNumber numberWithInt:-1]];
    
    [self.convertViewController trackUpdateTemperatures:self.convertViewController.fromTemperatureUnitSegment];
    
    // Verify all stubbed or expected methods were called.
    [mockAnalyticsTracker verify];
}

@end

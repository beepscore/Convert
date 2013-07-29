//
//  ConvertViewController_Private.h
//  Convert
//
//  Created by Steve Baker on 7/28/13.
//  Copyright Beepscore LLC 2013. All rights reserved.
//
///  Expose properties for use by unit tests

#import "GAITracker.h"

@interface ConvertViewController ()

@property(nonatomic, weak)IBOutlet UISegmentedControl *fromTemperatureUnitSegment;
@property(nonatomic, weak)IBOutlet UISegmentedControl *toTemperatureUnitSegment;

@property(nonatomic, strong) id<GAITracker> googleAnalyticsTracker;

- (void)trackUpdateTemperatures:(id)sender;

@end

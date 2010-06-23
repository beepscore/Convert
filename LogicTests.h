//
//  LogicTests.h
//  Convert
//
//  Created by Steve Baker on 6/23/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

//  Application unit tests contain unit test code that must be injected into an application to run correctly.
//  Define USE_APPLICATION_UNIT_TEST to 0 if the unit test code is designed to be linked into an independent test executable.

//#define USE_APPLICATION_UNIT_TEST 1
#define USE_APPLICATION_UNIT_TEST 0

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>

//#import "application_headers" as required
#import "Converter.h"

@interface LogicTests : SenTestCase {
    // in Xcode Groups & Files/Classes, find the Converter.m file.
    // Hold Option key and drag Converter.m file to Groups & Files/Targets/LogicTests/Compile Sources
    // This puts a reference to the Converter.m file in both folders.  Both references point to the same project file.
    Converter* converter;
}

#if USE_APPLICATION_UNIT_TEST
- (void) testAppDelegate;       // simple test on application
#else

- (void) testConvertZeroDegreesToK;
- (void) testConvertZeroKtoTemperature;

#endif

@end

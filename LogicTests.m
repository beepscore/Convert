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

#else                           // all code under test must be linked into the Unit Test bundle



#pragma mark Test Setup/teardown

// setUp is called automatically before each test-case method (method whose name starts with 'test').
- (void) setUp
{
    NSLog(@"%@ setUp", self.name);
    converter = [[Converter alloc] init];
    STAssertNotNil(converter, @"Cannot create instance of Converter");
}

// tearDown method is called automatically after each test-case method (method whose name starts with 'test').
- (void) tearDown
{
    NSLog(@"%@ tearDown", self.name);
}


//- (void) testMath
//{    
//    STAssertTrue((1+1)==2, @"Compiler isn't feeling well today :-(" );    
//}


- (void) testConvertZeroDegreesToK
{ 
    NSLog(@"%@ start", self.name);
    
    NSNumber* inputTemperature;
    NSNumber* outputTemperature;
    
    // Use convenience methods.  Don't worry about minimizing memory use here,
    // these logic unit tests run only in simulator, not on device
    inputTemperature = @0.0;
    outputTemperature = [converter convertTemperature:inputTemperature toKFromUnit:@"K"];
    double outputTemperatureSpec = 0.0;    
    STAssertEqualsWithAccuracy([outputTemperature doubleValue],
                               outputTemperatureSpec,
                               0.01,
                               @"returned %g K should be %g K", [inputTemperature doubleValue], outputTemperatureSpec);
    
    inputTemperature = @0.0;
    outputTemperature = [converter convertTemperature:inputTemperature toKFromUnit:@"C"];
    outputTemperatureSpec = 273.15;
    STAssertEqualsWithAccuracy([outputTemperature doubleValue],
                               outputTemperatureSpec,
                               0.01,
                               @"input %g C should return %g K", [inputTemperature doubleValue], outputTemperatureSpec);
    
    inputTemperature = @0.0;
    outputTemperature = [converter convertTemperature:inputTemperature toKFromUnit:@"F"];
    outputTemperatureSpec = 255.372;
    STAssertEqualsWithAccuracy([outputTemperature doubleValue],
                               outputTemperatureSpec,
                               0.01,
                               @"input %g F should return %g K", [inputTemperature doubleValue], outputTemperatureSpec);    
    
    NSLog(@"%@ end", self.name);
}


- (void) testConvertZeroKtoTemperature
{ 
    NSLog(@"%@ start", self.name);
    
    NSNumber* inputTemperature;
    NSNumber* outputTemperature;
    
    inputTemperature = @0.0;
    outputTemperature = [converter convertTemperature:inputTemperature fromKToUnit:@"K"];
    double outputTemperatureSpec = 0.0;    
    STAssertEqualsWithAccuracy([outputTemperature doubleValue],
                               outputTemperatureSpec,
                               0.01,
                               @"input %g K should return %g K", [inputTemperature doubleValue], outputTemperatureSpec);
    
    inputTemperature = @0.0;
    outputTemperature = [converter convertTemperature:inputTemperature fromKToUnit:@"C"];
    outputTemperatureSpec = -273.15;    
    STAssertEqualsWithAccuracy([outputTemperature doubleValue],
                               outputTemperatureSpec,
                               0.01,
                               @"input %g K should return %g C", [inputTemperature doubleValue], outputTemperatureSpec);
    
    inputTemperature = @0.0;
    outputTemperature = [converter convertTemperature:inputTemperature fromKToUnit:@"F"];
    outputTemperatureSpec = -459.67;    
    STAssertEqualsWithAccuracy([outputTemperature doubleValue],
                               outputTemperatureSpec,
                               0.01,
                               @"input %g K should return %g F", [inputTemperature doubleValue], outputTemperatureSpec);
    
    NSLog(@"%@ end", self.name);
}


#endif


@end

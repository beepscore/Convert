//
//  ConverterTests.m
//  Convert
//
//  Created by Steve Baker on 7/28/13.
//  Copyright (c) 2013 Beepscore LLC. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Converter.h"

@interface ConverterTests : SenTestCase
@property Converter *converter;
@end


@implementation ConverterTests

#pragma mark Test Setup/teardown

// setUp is called automatically before each test-case method (method whose name starts with 'test').
- (void) setUp
{
    self.converter = [[Converter alloc] init];
    STAssertNotNil(self.converter, @"Cannot create instance of Converter");
}

// tearDown method is called automatically after each test-case method (method whose name starts with 'test').
- (void) tearDown
{
}


- (void) testConvertZeroDegreesToK
{ 
    NSLog(@"%@ start", self.name);
    
    NSNumber* inputTemperature;
    NSNumber* outputTemperature;
    
    // Use convenience methods.  Don't worry about minimizing memory use here,
    // these logic unit tests run only in simulator, not on device
    inputTemperature = @0.0;
    outputTemperature = [self.converter convertTemperature:inputTemperature toKFromUnit:@"K"];
    double outputTemperatureSpec = 0.0;    
    STAssertEqualsWithAccuracy([outputTemperature doubleValue],
                               outputTemperatureSpec,
                               0.01,
                               @"returned %g K should be %g K", [inputTemperature doubleValue], outputTemperatureSpec);
    
    inputTemperature = @0.0;
    outputTemperature = [self.converter convertTemperature:inputTemperature toKFromUnit:@"C"];
    outputTemperatureSpec = 273.15;
    STAssertEqualsWithAccuracy([outputTemperature doubleValue],
                               outputTemperatureSpec,
                               0.01,
                               @"input %g C should return %g K", [inputTemperature doubleValue], outputTemperatureSpec);
    
    inputTemperature = @0.0;
    outputTemperature = [self.converter convertTemperature:inputTemperature toKFromUnit:@"F"];
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
    outputTemperature = [self.converter convertTemperature:inputTemperature fromKToUnit:@"K"];
    double outputTemperatureSpec = 0.0;    
    STAssertEqualsWithAccuracy([outputTemperature doubleValue],
                               outputTemperatureSpec,
                               0.01,
                               @"input %g K should return %g K", [inputTemperature doubleValue], outputTemperatureSpec);
    
    inputTemperature = @0.0;
    outputTemperature = [self.converter convertTemperature:inputTemperature fromKToUnit:@"C"];
    outputTemperatureSpec = -273.15;    
    STAssertEqualsWithAccuracy([outputTemperature doubleValue],
                               outputTemperatureSpec,
                               0.01,
                               @"input %g K should return %g C", [inputTemperature doubleValue], outputTemperatureSpec);
    
    inputTemperature = @0.0;
    outputTemperature = [self.converter convertTemperature:inputTemperature fromKToUnit:@"F"];
    outputTemperatureSpec = -459.67;    
    STAssertEqualsWithAccuracy([outputTemperature doubleValue],
                               outputTemperatureSpec,
                               0.01,
                               @"input %g K should return %g F", [inputTemperature doubleValue], outputTemperatureSpec);
    
    NSLog(@"%@ end", self.name);
}

@end

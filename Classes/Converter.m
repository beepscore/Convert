//
//  Converter.m
//  Convert
//
//  Created by Steve Baker on 1/6/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "Converter.h"

// conversion factors for Kelvin to Celsius, Fahrenheit, Rankine
const double BS_K_TO_C_SLOPE = 1.0;
const double BS_K_TO_C_OFFSET = -273.15;
const double BS_K_TO_F_SLOPE = 1.8;
const double BS_K_TO_F_OFFSET = -459.67;
const double BS_K_TO_R_SLOPE = 1.8;
const double BS_K_TO_R_OFFSET = 0.0;

@implementation Converter

@synthesize temperatureK;
@synthesize raisedTemperatureToAbsoluteZero;

#pragma mark initializers


#pragma mark -
#pragma mark destructors and memory cleanUp
- (void)cleanUp {
    [temperatureK release], temperatureK = nil;
}


- (void)dealloc {
    [self cleanUp];
    
    [super dealloc];
}


- (NSNumber *)convertTemperature:(NSNumber *)aTemperature
                     toKFromUnit:(NSString *)fromTemperatureUnit {
    
    double temperatureDegK = 0.0;
    
    if (BS_UNIT_DEG_C == fromTemperatureUnit) {
        temperatureDegK = ([aTemperature doubleValue] - BS_K_TO_C_OFFSET);
    }
    if (BS_UNIT_DEG_F == fromTemperatureUnit) {
        temperatureDegK = (([aTemperature doubleValue] - BS_K_TO_F_OFFSET)/BS_K_TO_F_SLOPE);
    }
    if (BS_UNIT_DEG_K == fromTemperatureUnit) {
        temperatureDegK = [aTemperature doubleValue];
    }
    if (BS_UNIT_DEG_R == fromTemperatureUnit) {
        temperatureDegK = ([aTemperature doubleValue]/BS_K_TO_R_SLOPE);
    }
    
    if (temperatureDegK < 0.0) {
        temperatureDegK = 0.0;
        raisedTemperatureToAbsoluteZero = YES;
    } else {
        raisedTemperatureToAbsoluteZero = NO;
    }

    // ????: Homework goal is minimize use of autoreleased objects.
    // I don't see an easy way to avoid using one here.
    // Could re-write method to not return NSNumber object,
    // instead return type double or set property temperatureK.
    return [NSNumber numberWithDouble:temperatureDegK];
}


- (NSNumber *)convertTemperature:(NSNumber *)aTemperatureInK
                     fromKToUnit:(NSString *)toTemperatureUnit {

    double temperatureDegK = [aTemperatureInK doubleValue];

    if (temperatureDegK < 0.0) {
        temperatureDegK = 0.0;
        raisedTemperatureToAbsoluteZero = YES;
    } else {
        raisedTemperatureToAbsoluteZero = NO;
    }
    
    if (BS_UNIT_DEG_C == toTemperatureUnit) {
        return [NSNumber numberWithDouble:(temperatureDegK + BS_K_TO_C_OFFSET)];
    }
    if (BS_UNIT_DEG_F == toTemperatureUnit) {
        return [NSNumber numberWithDouble:
                ((BS_K_TO_F_SLOPE * temperatureDegK) + BS_K_TO_F_OFFSET)];
    }
    if (BS_UNIT_DEG_K == toTemperatureUnit) {
        return [NSNumber numberWithDouble:temperatureDegK];
    }
    if (BS_UNIT_DEG_R == toTemperatureUnit) {
        return [NSNumber numberWithDouble:(BS_K_TO_R_SLOPE * temperatureDegK)];
    }
    return nil;    
}


@end

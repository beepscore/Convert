//
//  Converter.m
//  Convert
//
//  Created by Steve Baker on 1/6/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "Converter.h"

// conversion factors for Kelvin to Celsius, Farenheit, Rankine
const double BS_K_TO_C_SLOPE = 1.0;
const double BS_K_TO_C_OFFSET = -273.15;
const double BS_K_TO_F_SLOPE = 1.8;
const double BS_K_TO_F_OFFSET = -459.67;
const double BS_K_TO_R_SLOPE = 1.8;
const double BS_K_TO_R_OFFSET = 0.0;

@implementation Converter

@synthesize temperatureK;


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
    
    if (BS_UNIT_DEG_C == fromTemperatureUnit) {
        return [NSNumber numberWithDouble:
                ([aTemperature doubleValue] - BS_K_TO_C_OFFSET)];
    }
    if (BS_UNIT_DEG_F == fromTemperatureUnit) {
        return [NSNumber numberWithDouble:
                (([aTemperature doubleValue] - BS_K_TO_F_OFFSET)/BS_K_TO_F_SLOPE)];
    }
    if (BS_UNIT_DEG_K == fromTemperatureUnit) {
        return aTemperature;
    }
    if (BS_UNIT_DEG_R == fromTemperatureUnit) {
        return [NSNumber numberWithDouble:
                ([aTemperature doubleValue]/BS_K_TO_R_SLOPE)];
    }
    return nil;    
}


- (NSNumber *)convertTemperature:(NSNumber *)aTemperatureInK
                     fromKToUnit:(NSString *)toTemperatureUnit {
    
    if (BS_UNIT_DEG_C == toTemperatureUnit) {
        return [NSNumber numberWithDouble:
                ([aTemperatureInK doubleValue] + BS_K_TO_C_OFFSET)];
    }
    if (BS_UNIT_DEG_F == toTemperatureUnit) {
        return [NSNumber numberWithDouble:
                ((BS_K_TO_F_SLOPE * [aTemperatureInK doubleValue]) + BS_K_TO_F_OFFSET)];
    }
    if (BS_UNIT_DEG_K == toTemperatureUnit) {
        return aTemperatureInK;
    }
    if (BS_UNIT_DEG_R == toTemperatureUnit) {
        return [NSNumber numberWithDouble:
                (BS_K_TO_R_SLOPE * [aTemperatureInK doubleValue])];
    }
    return nil;    
}


@end

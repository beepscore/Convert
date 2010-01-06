//
//  Converter.m
//  Convert
//
//  Created by Steve Baker on 1/6/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "Converter.h"

// conversion factors for Kelvin to Celsius, Farenheit, Rankine
const float BSKToCSlope = 1.0;
const float BSKToCOffset = -273.15;
const float BSKToFSlope = 1.8;
const float BSKToFOffset = -459.67;
const float BSKToRSlope = 1.8;
const float BSKToROffset = 0.0;

@implementation Converter

@synthesize temperatureK;


#pragma mark initializers


#pragma mark -
#pragma mark destructors and memory cleanUp
- (void)cleanUp {
  // [myIvar release], myIvar = nil;
    [temperatureK release], temperatureK = nil;
}


- (void)dealloc {
    [self cleanUp];
    
    [super dealloc];
}


- (float)linearTransform:(float)anInput
                   slope:(float)aSlope
                  offset:(float)anOffset {
    
    return (aSlope * anInput) + anOffset;
}


- (float)temperatureKFromC:(float)temperatureC {
    
    return [self linearTransform:temperatureC
                           slope:(1.0/BSKToCSlope)
                          offset:-BSKToCOffset];
}

- (float)temperatureCFromK:(float)aTemperatureK {
    
    return [self linearTransform:aTemperatureK
                           slope:BSKToCSlope
                          offset:BSKToCOffset];
}

- (float)temperatureFFromK:(float)aTemperatureK {
    
    return [self linearTransform:aTemperatureK
                           slope:BSKToFSlope
                          offset:BSKToFOffset];
}

@end

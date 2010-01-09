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
@synthesize tidbits;


#pragma mark initializers
// designated initializer
- (id)init {
    if (self = [super init]) {
        
        // TODO: Move tidbits data into a file, plist, or database
        tidbits = [[NSDictionary alloc] initWithObjectsAndKeys:
                   @"-273.15°C absolute zero", @"0",
                   @"-210°C nitrogen boils", @"63", 
                   @"−89.2°C record coldest temperature in Antartica", @"184",
                   @"-40°C and -40°F are the same temperature", @"233",
                   @"-38.72°C mercury freezes", @"234",
                   @"-18°C boogers freeze (estimated)", @"255",
                   @"0°C water freezes", @"273",
                   @"27.5°C average annual temperature in Hawaii", @"300",
                   @"37°C human body temperature", @"310",
                   @"40°C hummingbird body temperature", @"313",
                   @"57.1°C record hottest temperature in Death Valley CA", @"330",
                   @"70°C Wood's metal melts", @"343",
                   @"100°C water boils", @"373",
                   @"660°C aluminum melts", @"933",
                   @"1250°C active volcano with molten lava", @"1520",
                   @"1300-1700°C steel melts", @"1570",
                   @"6000°C Sun's surface temperature", @"6273", nil];
    }
    return self;
}



#pragma mark -
#pragma mark destructors and memory cleanUp
- (void)cleanUp {
    [temperatureK release], temperatureK = nil;
    [tidbits release], tidbits = nil;
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

- (NSString *)tidbitForTemperatureK:(int)aTemperatureK {
    // TODO: replace convenience method autoreleased object with explicit init, release?
//    return [self.tidbits valueForKey:[NSString stringWithFormat:@"%f", 330]];
    return [self.tidbits valueForKey:@"330"];
}


@end

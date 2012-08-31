//
//  Converter.m
//  Convert
//
//  Created by Steve Baker on 1/6/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "Converter.h"

// Ref http://stackoverflow.com/questions/25746/whats-the-difference-between-a-string-constant-and-a-string-literal
NSString * const kBSUnitDegreeC = @"C";
NSString * const kBSUnitDegreeF = @"F";
NSString * const kBSUnitDegreeK = @"K";
NSString * const kBSUnitDegreeR = @"R";


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
        //       for keys, use string constants instead of string literals?
        tidbits = [[NSDictionary alloc] initWithObjectsAndKeys:
                   @"0°K absolute zero", @"0",
                   @"2.725°K cosmic background radiation", @"2",
                   @"63°K nitrogen boils", @"63", 
                   @"135°K superconductivity", @"135", 
                   @"−89.2°C coldest temperature in Antartica", @"184",
                   @"−78.5°C dry ice sublimes to gas", @"194",
                   @"-60°C nylon brittle", @"213",
                   @"-40°C = -40°F", @"233",
                   @"-38.72°C mercury freezes", @"234",
                   @"-33.34°C ammonia boils", @"239",
                   @"-19°C diesel fuel turns to gel", @"254",
                   @"-18°C boogers freeze (estimated)", @"255",
                   @"-1.9°C ocean saltwater freezes", @"271",
                   @"0°C water freezes", @"273",
                   @"38-40°F food refrigerator temperature", @"276",
                   @"3.9°C fresh water most dense", @"277",
                   @"60°F mosquitos lethargic", @"288",
                   @"68°F water too hot for salmon", @"293",
                   @"27.5°C average temperature in Hawaii", @"300",
                   @"37°C human core temperature", @"310",
                   @"100-106°F maximum safe bath water temperature", @"311",
                   @"40°C hummingbird body temperature", @"313",
                   @"57.1°C hottest temperature in Death Valley CA", @"330",
                   @"70°C Wood's metal melts", @"343",
                   @"100°C water boils", @"373",
                   @"451°F paper burns", @"505",
                   @"255-265°C nylon melts", @"528",
                   @"660°C aluminum melts", @"933",
                   @"1250°C lava melts", @"1520",
                   @"1300-1700°C steel melts", @"1570",
                   @"2500°C thermite reacts", @"2770",
                   @"6000°C Sun's surface", @"6273", nil];
    }
    return self;
}


#pragma mark -
#pragma mark destructors


- (NSNumber *)convertTemperature:(NSNumber *)aTemperature
                     toKFromUnit:(NSString *)fromTemperatureUnit {
    
    double temperatureDegK = 0.0;
    
    if (kBSUnitDegreeC == fromTemperatureUnit) {
        temperatureDegK = ([aTemperature doubleValue] - BS_K_TO_C_OFFSET);
    }
    if (kBSUnitDegreeF == fromTemperatureUnit) {
        temperatureDegK = (([aTemperature doubleValue] - BS_K_TO_F_OFFSET)/BS_K_TO_F_SLOPE);
    }
    if (kBSUnitDegreeK == fromTemperatureUnit) {
        temperatureDegK = [aTemperature doubleValue];
    }
    if (kBSUnitDegreeR == fromTemperatureUnit) {
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
    
    if (kBSUnitDegreeC == toTemperatureUnit) {
        return [NSNumber numberWithDouble:(temperatureDegK + BS_K_TO_C_OFFSET)];
    }
    if (kBSUnitDegreeF == toTemperatureUnit) {
        return [NSNumber numberWithDouble:
                ((BS_K_TO_F_SLOPE * temperatureDegK) + BS_K_TO_F_OFFSET)];
    }
    if (kBSUnitDegreeK == toTemperatureUnit) {
        return [NSNumber numberWithDouble:temperatureDegK];
    }
    if (kBSUnitDegreeR == toTemperatureUnit) {
        return [NSNumber numberWithDouble:(BS_K_TO_R_SLOPE * temperatureDegK)];
    }
    return nil;    
}

- (NSString *)tidbitForTemperatureK:(NSNumber *)aTemperatureK {

    // use NSInteger or NSUInteger instead of int.
    // ref http://theocacao.com/document.page/510
    // use NSUInteger, because key should never be negative
    NSUInteger tidbitKeyIntFloor = 0;    
    NSString *tidbitKey;

    // find key at or below input temperature
    // dictionary isn't sorted, so enumerate over every element
    for (tidbitKey in self.tidbits)
    {
        NSUInteger tidbitKeyIntValue = [tidbitKey intValue];
        
        if ( (tidbitKeyIntValue > tidbitKeyIntFloor) 
            && (tidbitKeyIntValue <= [aTemperatureK intValue]) ) {
            
            tidbitKeyIntFloor = tidbitKeyIntValue;
        }        
    }  
    // use initWithFormat: instead of convenience method stringWithFormat:
    //return [self.tidbits valueForKey:[NSString stringWithFormat:@"%d",tidbitKeyIntFloor]];
    
     NSString* tidbitKeyString = [[NSString alloc] initWithFormat:@"%d",tidbitKeyIntFloor];
     NSString* tidbitString = [self.tidbits valueForKey:tidbitKeyString];
     return tidbitString;
}

@end

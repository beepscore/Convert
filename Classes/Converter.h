//
//  Converter.h
//  Convert
//
//  Created by Steve Baker on 1/6/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//  Reference: http://en.wikipedia.org/wiki/Temperature_conversion

#import <UIKit/UIKit.h>

// temperature units are degrees Celsius, Fahrenheit, Kelvin, Rankine
#define BS_UNIT_DEG_C @"C"
#define BS_UNIT_DEG_F @"F"
#define BS_UNIT_DEG_K @"K"
#define BS_UNIT_DEG_R @"R"

@interface Converter : NSObject { 
    // temperature in degrees Kelvin.  Minimum value = 0 (absolute zero).
    NSNumber *temperatureK;
    // flag if conversion raised temperature to absolute zero.
    BOOL raisedTemperatureToAbsoluteZero;
    
    // key is string temperature in degrees K.  value is string temperature fact.
    NSDictionary *tidbits;
}
@property(nonatomic,retain)NSNumber *temperatureK;
@property(nonatomic,assign)BOOL raisedTemperatureToAbsoluteZero;
@property(nonatomic,retain)NSDictionary *tidbits;


// Converts temperature from C, F, or R to K.
// If necessary, raises temperature to absolute zero and sets flag.
- (NSNumber *)convertTemperature:(NSNumber *)aTemperature
                toKFromUnit:(NSString *)fromTemperatureUnit;


// Converts temperature from K to C, F, or R.
// If necessary, raises temperature to absolute zero and sets flag.
- (NSNumber *)convertTemperature:(NSNumber *)aTemperatureInK
                fromKToUnit:(NSString *)toTemperatureUnit;

- (NSString *)tidbitForTemperatureK:(int)aTemperatureK;

@end

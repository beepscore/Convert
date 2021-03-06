//
//  Converter.h
//  Convert
//
//  Created by Steve Baker on 1/6/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//  Reference: http://en.wikipedia.org/wiki/Temperature_conversion

#import <UIKit/UIKit.h>

// temperature units are degrees Celsius, Fahrenheit, Kelvin, Rankine
extern NSString * const kBSUnitDegreeC;
extern NSString * const kBSUnitDegreeF;
extern NSString * const kBSUnitDegreeK;
extern NSString * const kBSUnitDegreeR;

@interface Converter : NSObject {
    // Xcode automatically adds instance variables to back properties
}
#pragma mark - properties
// temperature in degrees Kelvin.  Minimum value = 0 (absolute zero).
@property(nonatomic,strong)NSNumber *temperatureK;
// flag set if a conversion method raised temperature to absolute zero.
@property(nonatomic,assign)BOOL raisedTemperatureToAbsoluteZero;

// key is string temperature in degrees K.  value is string temperature fact.
// Use copy instead of strong for types that have mutable subtypes like NSString, NSArray, NSDictionary.
// This prevents getting a reference to an underlying mutable type that someone else could change.
@property(nonatomic,copy, readonly)NSDictionary *tidbits;

// Converts temperature from C, F, or R to K.
// If necessary, raises temperature to absolute zero and sets flag.
- (NSNumber *)convertTemperature:(NSNumber *)aTemperature
                toKFromUnit:(NSString *)fromTemperatureUnit;


// Converts temperature from K to C, F, or R.
// If necessary, raises temperature to absolute zero and sets flag.
- (NSNumber *)convertTemperature:(NSNumber *)aTemperatureInK
                fromKToUnit:(NSString *)toTemperatureUnit;


// returns a fact about a temperature close to the argument.
- (NSString *)tidbitForTemperatureK:(NSNumber *)aTemperatureK;

@end

//
//  Converter.h
//  Convert
//
//  Created by Steve Baker on 1/6/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

//extern const NSString *BS_UNIT_DEG_F;
//extern const NSString *BS_UNIT_DEG_K;
//extern const NSString *BS_UNIT_DEG_R;    

#define BS_UNIT_DEG_C @"degC"
#define BS_UNIT_DEG_F @"degF"
#define BS_UNIT_DEG_K @"degK"
#define BS_UNIT_DEG_R @"degR"

@interface Converter : NSObject { 
    // temperature in degrees Kelvin
    NSNumber *temperatureK;
}
@property(nonatomic,retain) NSNumber *temperatureK;

- (NSNumber *)convertTemperature:(NSNumber *)aTemperature
                toKFromUnit:(NSString *)fromTemperatureUnit;

- (NSNumber *)convertTemperature:(NSNumber *)aTemperatureInK
                fromKtoUnit:(NSString *)toTemperatureUnit;

- (NSNumber *)convertTemperature:(NSNumber *)aTemperature
                   fromUnit:(NSString *)fromTemperatureUnit
                     toUnit:(NSString *)toTemperatureUnit;

@end

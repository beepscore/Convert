//
//  Converter.h
//  Convert
//
//  Created by Steve Baker on 1/6/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BS_UNIT_DEG_C @"degC"
#define BS_UNIT_DEG_F @"degF"
#define BS_UNIT_DEG_K @"degK"
#define BS_UNIT_DEG_R @"degR"

@interface Converter : NSObject { 
    // temperature in degrees Kelvin.  Minimum value = 0 (absolute zero).
    NSNumber *temperatureK;
}
@property(nonatomic,retain) NSNumber *temperatureK;

- (NSNumber *)convertTemperature:(NSNumber *)aTemperature
                toKFromUnit:(NSString *)fromTemperatureUnit;

- (NSNumber *)convertTemperature:(NSNumber *)aTemperatureInK
                fromKToUnit:(NSString *)toTemperatureUnit;

@end

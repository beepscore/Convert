//
//  Converter.h
//  Convert
//
//  Created by Steve Baker on 1/6/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Converter : NSObject {
    NSNumber *temperatureK;
}
@property(nonatomic,retain) NSNumber *temperatureK;

- (float)temperatureKFromC:(float)temperatureC;
- (float)temperatureCFromK:(float)aTemperatureK;
- (float)temperatureFFromK:(float)aTemperatureK;

@end

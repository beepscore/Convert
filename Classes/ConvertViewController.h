//
//  ConvertViewController.h
//  Convert
//
//  Created by Steve Baker on 1/5/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Converter;

@interface ConvertViewController : UIViewController <UITextFieldDelegate> {
    Converter *converter;
    UITextField *convertFromField;
    UILabel *convertToLabel;
    UISegmentedControl *fromTemperatureUnitSegment;
    NSString *fromUnit;
    UISegmentedControl *toTemperatureUnitSegment;
    NSString *toUnit;
    UILabel *raisedTemperatureToAbsoluteZeroLabel;
    UILabel *temperatureTidbitLabel;
}
#pragma mark -
#pragma mark properties

@property(nonatomic,retain) Converter *converter;
@property(nonatomic,retain)IBOutlet UITextField *convertFromField;
@property(nonatomic,retain)IBOutlet UILabel *convertToLabel;
@property(nonatomic,retain)IBOutlet UISegmentedControl *fromTemperatureUnitSegment;
@property(nonatomic,retain)IBOutlet UISegmentedControl *toTemperatureUnitSegment;
@property(nonatomic,retain)IBOutlet UILabel *raisedTemperatureToAbsoluteZeroLabel;
@property(nonatomic,retain)IBOutlet UILabel *temperatureTidbitLabel;

@property(nonatomic,retain) NSString *fromUnit;
@property(nonatomic,retain) NSString *toUnit;

- (IBAction)updateTemperatures:(id)sender;
- (IBAction)backgroundTap:(id)sender;

@end

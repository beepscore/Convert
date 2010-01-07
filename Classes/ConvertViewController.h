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
    NSString *toKFromUnit;
    UISegmentedControl *toTemperatureUnitSegment;
    NSString *fromKToUnit;
}
#pragma mark -
#pragma mark properties

@property(nonatomic,retain) Converter *converter;
@property(nonatomic,retain)IBOutlet UITextField *convertFromField;
@property(nonatomic,retain)IBOutlet UILabel *convertToLabel;
@property(nonatomic,retain)IBOutlet UISegmentedControl *fromTemperatureUnitSegment;
@property(nonatomic,retain)IBOutlet UISegmentedControl *toTemperatureUnitSegment;

@property(nonatomic,retain) NSString *toKFromUnit;
@property(nonatomic,retain) NSString *fromKToUnit;


- (IBAction)updateTemperatures:(id)sender;

@end

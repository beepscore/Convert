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
    // Xcode automatically adds instance variables to back properties
}
#pragma mark properties
@property(nonatomic,retain) Converter *converter;
@property(nonatomic,retain)IBOutlet UIView *backgroundCold;
@property(nonatomic,retain)IBOutlet UIView *backgroundHot;
@property(nonatomic,retain)IBOutlet UITextField *convertFromField;
@property(nonatomic,retain)IBOutlet UITextField *convertToField;
@property(nonatomic,retain)IBOutlet UISegmentedControl *fromTemperatureUnitSegment;
@property(nonatomic,retain)IBOutlet UISegmentedControl *toTemperatureUnitSegment;
@property(nonatomic,retain)IBOutlet UILabel *raisedTemperatureToAbsoluteZeroLabel;
@property(nonatomic,retain)IBOutlet UILabel *temperatureTidbitLabel;

// Use copy instead of retain for types that have mutable subtypes like NSString, NSArray, NSDictionary.
// This prevents getting a reference to an underlying mutable type that someone else could change.
@property(nonatomic,copy) NSString *fromUnit;
@property(nonatomic,copy) NSString *toUnit;

- (IBAction)updateTemperatures:(id)sender;
- (IBAction)backgroundTap:(id)sender;

@end

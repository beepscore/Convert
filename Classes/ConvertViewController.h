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
@property(nonatomic,strong) Converter *converter;
@property(nonatomic,strong)IBOutlet UIView *backgroundCold;
@property(nonatomic,strong)IBOutlet UIView *backgroundHot;
@property(nonatomic,strong)IBOutlet UITextField *convertFromField;
@property(nonatomic,strong)IBOutlet UITextField *convertToField;
@property(nonatomic,strong)IBOutlet UISegmentedControl *fromTemperatureUnitSegment;
@property(nonatomic,strong)IBOutlet UISegmentedControl *toTemperatureUnitSegment;
@property(nonatomic,strong)IBOutlet UILabel *raisedTemperatureToAbsoluteZeroLabel;
@property(nonatomic,strong)IBOutlet UILabel *temperatureTidbitLabel;

// Use copy instead of strong for types that have mutable subtypes like NSString, NSArray, NSDictionary.
// This prevents getting a reference to an underlying mutable type that someone else could change.
@property(nonatomic,copy) NSString *fromUnit;
@property(nonatomic,copy) NSString *toUnit;

- (IBAction)updateTemperatures:(id)sender;
- (IBAction)backgroundTap:(id)sender;

@end

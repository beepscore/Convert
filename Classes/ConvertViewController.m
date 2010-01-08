//
//  ConvertViewController.m
//  Convert
//
//  Created by Steve Baker on 1/5/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import "ConvertViewController.h"
#import "Converter.h"

@implementation ConvertViewController

#pragma mark -
#pragma mark properties

@synthesize converter;
@synthesize convertFromField;
@synthesize convertToLabel;
@synthesize fromTemperatureUnitSegment;
@synthesize fromUnit;
@synthesize toTemperatureUnitSegment;
@synthesize toUnit;
@synthesize raisedTemperatureToAbsoluteZeroLabel;


#pragma mark -
#pragma mark destructors and memory cleanUp
- (void)cleanUp {
    [converter release], converter = nil;
    [convertFromField release], convertFromField = nil;
    [convertToLabel release], convertToLabel = nil;
    [fromTemperatureUnitSegment release], fromTemperatureUnitSegment = nil;
    [fromUnit release], fromUnit = nil;
    [toTemperatureUnitSegment release], toTemperatureUnitSegment = nil;
    [toUnit release], toUnit = nil;
    [raisedTemperatureToAbsoluteZeroLabel release], raisedTemperatureToAbsoluteZeroLabel = nil;
}


- (void)dealloc {
    [self cleanUp];
    
    [super dealloc];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    [self cleanUp];
}

#pragma mark -

- (void)viewDidLoad {
    converter = [[Converter alloc] init];
}

// This method is called by the input field and by both segmented controls.
- (IBAction)updateTemperatures:(id)sender {
    
    // read temperature units we are converting "from"
    if (0 == [fromTemperatureUnitSegment selectedSegmentIndex])
        self.fromUnit = BS_UNIT_DEG_C;    
    if (1 == [fromTemperatureUnitSegment selectedSegmentIndex])
        self.fromUnit = BS_UNIT_DEG_F;    
    if (2 == [fromTemperatureUnitSegment selectedSegmentIndex])
        self.fromUnit = BS_UNIT_DEG_K;    
    if (3 == [fromTemperatureUnitSegment selectedSegmentIndex])
        self.fromUnit = BS_UNIT_DEG_R;
    
    // Use a number formatter on text fields to handle localization and user prefs
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    // This prevents rounding away the decimal portion
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    // don't use this.  For example it would cause 0.003 to display as 0.00
    // [formatter setMaximumFractionDigits:2];

    // Convert input to a valid temperature.  Store result in model property temperatureK.
    // TODO: replace autoreleased object with explicit init, release?
    NSNumber *fromTemperature = [formatter numberFromString:self.convertFromField.text];    
    self.converter.temperatureK = [self.converter convertTemperature:fromTemperature
                                                         toKFromUnit:self.fromUnit];

    // Notify user if model raised their input temperature to a physically valid value.
    if (self.converter.raisedTemperatureToAbsoluteZero) {
        self.raisedTemperatureToAbsoluteZeroLabel.text = @"Raised temperature to absolute zero";
    } else {
        self.raisedTemperatureToAbsoluteZeroLabel.text = @"";
    }
    
    // Convert model temperatureK back to view input units, refill input field with validated value.
    self.convertFromField.text = [formatter stringFromNumber:
                                  [self.converter convertTemperature:self.converter.temperatureK
                                                         fromKToUnit:self.fromUnit]];

    // read temperature units we are converting "to"  
    if (0 == [toTemperatureUnitSegment selectedSegmentIndex])
        self.toUnit = BS_UNIT_DEG_C;    
    if (1 == [toTemperatureUnitSegment selectedSegmentIndex])
        self.toUnit = BS_UNIT_DEG_F;    
    if (2 == [toTemperatureUnitSegment selectedSegmentIndex])
        self.toUnit = BS_UNIT_DEG_K;    
    if (3 == [toTemperatureUnitSegment selectedSegmentIndex])
        self.toUnit = BS_UNIT_DEG_R;    
    
    // Convert model property temperatureK to view output units, then fill output label
    self.convertToLabel.text = [formatter stringFromNumber:
                                [self.converter convertTemperature:self.converter.temperatureK
                                                       fromKToUnit:self.toUnit]];
    [formatter release];
}


#pragma mark -
#pragma mark textFieldDelegate methods
// called when user presses Return key (labeled "Done")  ref Dudney sec 4.6 pg 67
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // resignFirstResponder will cause keyboard to be dismissed
    [textField resignFirstResponder];
    return YES;
}

// Dismiss keyboard if user taps container view background.
// Note:  In IB, Changed container view's class from UIView to UIControl, so it will send Touch Down event.
// In IB, connected Touch Down event to IBAction backgroundTap
// Ref Mark and LaMarche "Beginning iPhone 3 Development" Ch 4 pg 75
- (IBAction)backgroundTap:(id)sender {
    // It's ok to send message resignFirstResponder even if reciever isn't first responder.
    [self.convertFromField resignFirstResponder];
}


// ref Dudney sec 4.6 pg 67
- (void)textFieldDidEndEditing:(UITextField *)textField {
        
    [self updateTemperatures:self];
}


@end

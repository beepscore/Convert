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
@synthesize toKFromUnit;
@synthesize toTemperatureUnitSegment;
@synthesize fromKToUnit;


#pragma mark -
#pragma mark destructors and memory cleanUp
- (void)cleanUp {
    [converter release], converter = nil;
    [convertFromField release], convertFromField = nil;
    [convertToLabel release], convertToLabel = nil;
    [fromTemperatureUnitSegment release], fromTemperatureUnitSegment = nil;
    [toKFromUnit release], toKFromUnit = nil;
    [toTemperatureUnitSegment release], toTemperatureUnitSegment = nil;
    [fromKToUnit release], fromKToUnit = nil;
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


- (IBAction)updateTemperatures:(id)sender {

    // read "From" temperature units
    if (0 == [fromTemperatureUnitSegment selectedSegmentIndex])
        self.toKFromUnit = BS_UNIT_DEG_C;    
    if (1 == [fromTemperatureUnitSegment selectedSegmentIndex])
        self.toKFromUnit = BS_UNIT_DEG_F;    
    if (2 == [fromTemperatureUnitSegment selectedSegmentIndex])
        self.toKFromUnit = BS_UNIT_DEG_K;    
    if (3 == [fromTemperatureUnitSegment selectedSegmentIndex])
        self.toKFromUnit = BS_UNIT_DEG_R;
    
    // set model temperatureK property in degrees K.
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];    
    NSNumber *fromTemperature = [formatter numberFromString:self.convertFromField.text];    
    [formatter release];
    self.converter.temperatureK = [self.converter convertTemperature:fromTemperature
                                                         toKFromUnit:self.toKFromUnit];
    // refill input field using model property
    self.convertFromField.text = [[self.converter convertTemperature:self.converter.temperatureK
                                                        fromKToUnit:self.toKFromUnit] stringValue];   
    
    // read "To" temperature units   
    if (0 == [toTemperatureUnitSegment selectedSegmentIndex])
        self.fromKToUnit = BS_UNIT_DEG_C;    
    if (1 == [toTemperatureUnitSegment selectedSegmentIndex])
        self.fromKToUnit = BS_UNIT_DEG_F;    
    if (2 == [toTemperatureUnitSegment selectedSegmentIndex])
        self.fromKToUnit = BS_UNIT_DEG_K;    
    if (3 == [toTemperatureUnitSegment selectedSegmentIndex])
        self.fromKToUnit = BS_UNIT_DEG_R;    
    
    // fill output label
    self.convertToLabel.text = [[self.converter convertTemperature:self.converter.temperatureK
                                                       fromKToUnit:self.fromKToUnit] stringValue];   
}


#pragma mark -
#pragma mark textFieldDelegate methods
// called when user presses Return key (labeled "Done")  ref Dudney sec 4.6 pg 67
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // resignFirstResponder will cause keyboard to be dismissed
    [textField resignFirstResponder];
    return YES;
}

// ref Dudney sec 4.6 pg 67
- (void)textFieldDidEndEditing:(UITextField *)textField {
    

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];    
    NSNumber *fromTemperature = [formatter numberFromString:self.convertFromField.text];    
    
    self.convertFromField.text = [formatter stringFromNumber:fromTemperature];
    [formatter release];

    [self updateTemperatures:self];
}


@end

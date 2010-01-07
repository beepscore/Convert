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
@synthesize toTemperatureUnitSegment;

#pragma mark -
#pragma mark destructors and memory cleanUp
- (void)cleanUp {
    [converter release], converter = nil;
    [convertFromField release], convertFromField = nil;
    [convertToLabel release], convertToLabel = nil;
    [fromTemperatureUnitSegment release], fromTemperatureUnitSegment = nil;
    [toTemperatureUnitSegment release], toTemperatureUnitSegment = nil;
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


- (void)updateTemperatures {

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *fromTemperature = [formatter numberFromString:self.convertFromField.text];    
    [formatter release];    
    
    self.converter.temperatureK = [self.converter convertTemperature:fromTemperature
                                                         toKFromUnit:BS_UNIT_DEG_C];
    
    NSNumber *toTemperature = [self.converter convertTemperature:self.converter.temperatureK
                                                     fromKtoUnit:BS_UNIT_DEG_C];

    self.convertToLabel.text = [NSString stringWithFormat:@"%1.2f", [toTemperature floatValue]];   

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
    
    [self updateTemperatures];
}



@end

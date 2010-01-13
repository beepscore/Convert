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
@synthesize backgroundCold;
@synthesize backgroundHot;
@synthesize convertFromField;
@synthesize convertToLabel;
@synthesize fromTemperatureUnitSegment;
@synthesize fromUnit;
@synthesize toTemperatureUnitSegment;
@synthesize toUnit;
@synthesize raisedTemperatureToAbsoluteZeroLabel;
@synthesize temperatureTidbitLabel;

#pragma mark -
#pragma mark destructors and memory cleanUp
// use cleanUp method to avoid repeating code in dealloc and in setView
- (void)cleanUp {
    [converter release], converter = nil;
    [backgroundCold release], backgroundHot = nil;
    [backgroundHot release], backgroundHot = nil;
    [convertFromField release], convertFromField = nil;
    [convertToLabel release], convertToLabel = nil;
    [fromTemperatureUnitSegment release], fromTemperatureUnitSegment = nil;
    [fromUnit release], fromUnit = nil;
    [toTemperatureUnitSegment release], toTemperatureUnitSegment = nil;
    [toUnit release], toUnit = nil;
    [raisedTemperatureToAbsoluteZeroLabel release], raisedTemperatureToAbsoluteZeroLabel = nil;
    [temperatureTidbitLabel release], temperatureTidbitLabel = nil;
}


- (void)dealloc {
    // Kris Markel prefers not calling other methods from within dealloc.
    [self cleanUp];
    
    [super dealloc];
}


// Release outlets in setView and dealloc instead of in viewDidUnload and dealloc
- (void)viewDidUnload {

}


// release IBOutlets in setView
// Ref http://developer.apple.com/iPhone/library/documentation/Cocoa/Conceptual/MemoryMgmt/Articles/mmNibObjects.html
//
// http://moodle.extn.washington.edu/mod/forum/discuss.php?d=3162
- (void)setView:(UIView *)aView {
    
    if (!aView) { // view is being set to nil        
        // set outlets to nil, e.g. 
        // self.anOutlet = nil;
        [self cleanUp];
    }    
    // Invoke super's implementation last    
    [super setView:aView];    
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.    
    [self setView:nil];
    
    // ????: this calls setView:nil, don't need line above?
    [super didReceiveMemoryWarning];	
	// Release any cached data, images, etc that aren't in use.
}


#pragma mark -
// reference http://forums.macrumors.com/archive/index.php/t-512718.html
- (void)updateBackgroundColors {
    
    // class methods.  Do not instantiate an object.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    const double TMedium = 273.0;
    const double THot = 473.0;
    
    if ([self.converter.temperatureK doubleValue] < TMedium) {
        // from temperature 0 to TMedium, decrease opacity from 1 to 0
        [self.backgroundCold setAlpha:(1.0 - ([self.converter.temperatureK doubleValue]/TMedium))];
        [self.backgroundHot setAlpha:0.0];        
    }
    else 
        if ([self.converter.temperatureK doubleValue] > THot) {
            [self.backgroundCold setAlpha:0.0];
            [self.backgroundHot setAlpha:1.0];
        } else {
            [self.backgroundCold setAlpha:0.0];
            // from TMedium to THot, increase opacity linearly from 0 to 1
            [self.backgroundHot setAlpha:(([self.converter.temperatureK doubleValue]-TMedium)/(THot-TMedium))];
        }
    [UIView commitAnimations];    
}


// This method is called by the input field and by both segmented controls.
- (IBAction)updateTemperatures:(id)sender {
    
    // read temperature units we are converting "from"
    if (0 == [fromTemperatureUnitSegment selectedSegmentIndex])
        self.fromUnit = kBSUnitDegreeC;    
    if (1 == [fromTemperatureUnitSegment selectedSegmentIndex])
        self.fromUnit = kBSUnitDegreeF;    
    if (2 == [fromTemperatureUnitSegment selectedSegmentIndex])
        self.fromUnit = kBSUnitDegreeK;    
    if (3 == [fromTemperatureUnitSegment selectedSegmentIndex])
        self.fromUnit = kBSUnitDegreeR;
    
    // Use a number formatter on text fields to handle localization and user prefs
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    // This prevents rounding away the decimal portion
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    // don't use this.  For example it would cause 0.003 to display as 0.00
    // [formatter setMaximumFractionDigits:2];
    
    // Convert input to a valid temperature.  Store result in model property temperatureK.
    
    // locally declared variable fromTemperature will autorelease after this method ends.
    // formatter numberFromString: is not a class convenience method (aka factory method).
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
        self.toUnit = kBSUnitDegreeC;    
    if (1 == [toTemperatureUnitSegment selectedSegmentIndex])
        self.toUnit = kBSUnitDegreeF;    
    if (2 == [toTemperatureUnitSegment selectedSegmentIndex])
        self.toUnit = kBSUnitDegreeK;    
    if (3 == [toTemperatureUnitSegment selectedSegmentIndex])
        self.toUnit = kBSUnitDegreeR;    
    
    // Convert model property temperatureK to view output units, then fill output label
    self.convertToLabel.text = [formatter stringFromNumber:
                                [self.converter convertTemperature:self.converter.temperatureK
                                                       fromKToUnit:self.toUnit]];
    
    [formatter release];
    
    // Display temperature tidbit
    self.temperatureTidbitLabel.text = [self.converter 
                                        tidbitForTemperatureK:self.converter.temperatureK];
    [self updateBackgroundColors];
}


- (void)viewDidLoad {
    converter = [[Converter alloc] init];
    [self updateTemperatures:self];
}


#pragma mark -
#pragma mark textFieldDelegate methods
// called when user presses Return key (labeled "Done")  ref Dudney sec 4.6 pg 67
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // resignFirstResponder will cause keyboard to be dismissed
    [textField resignFirstResponder];
    return YES;
}

// Dismiss keyboard if user taps view background.
// Note:  In IB, Changed class of container, backgroundCold and backgroundHot views
// from UIView to UIControl, so they will send Touch Down event.
// In IB, connected Touch Down event to IBAction backgroundTap
// Ref Mark and LaMarche "Beginning iPhone 3 Development" Ch 4 pg 75
- (IBAction)backgroundTap:(id)sender {
    // It's ok to send message resignFirstResponder even if receiver isn't first responder.
    [self.convertFromField resignFirstResponder];
}


// ref Dudney sec 4.6 pg 67
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self updateTemperatures:self];
}

@end

//
//  ConvertViewController.m
//  Convert
//
//  Created by Steve Baker on 1/5/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import "ConvertViewController.h"
#import "Converter.h"
#import "GAI.h"
#import "GAITracker.h"

@interface ConvertViewController ()
#pragma mark - properties
@property(nonatomic, weak)IBOutlet UIView *backgroundCold;
@property(nonatomic, weak)IBOutlet UIView *backgroundHot;
@property(nonatomic, weak)IBOutlet UITextField *convertFromField;
@property(nonatomic, weak)IBOutlet UITextField *convertToField;
@property(nonatomic, weak)IBOutlet UISegmentedControl *fromTemperatureUnitSegment;
@property(nonatomic, weak)IBOutlet UISegmentedControl *toTemperatureUnitSegment;
@property(nonatomic, weak)IBOutlet UILabel *raisedTemperatureToAbsoluteZeroLabel;
@property(nonatomic, weak)IBOutlet UILabel *temperatureTidbitLabel;

@property(nonatomic, strong) id<GAITracker> googleAnalyticsTracker;
@end

@implementation ConvertViewController


#pragma mark - Lifecycle management
- (void)viewDidLoad {
    
    // call super so it can respond
    [super viewDidLoad];
    
    self.converter = [[Converter alloc] init];
    [self updateTemperatures:self];
    
    // set accessibility label for use by UIAutomation
    // reference http://alexvollmer.com/posts/2010/07/03/working-with-uiautomation/
    // ????: This didn't seem to work for UIAutomation.  Need to set earlier, in initWithNibName:?
    self.fromTemperatureUnitSegment.isAccessibilityElement = YES;
    self.fromTemperatureUnitSegment.accessibilityLabel = @"fromTemperatureUnitSegment";
    self.toTemperatureUnitSegment.isAccessibilityElement = YES;
    self.toTemperatureUnitSegment.accessibilityLabel = @"toTemperatureUnitSegment";
    
    // Google Analytics
    self.googleAnalyticsTracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-42678217-1"];
    self.trackedViewName = @"ConvertView";
}

// Ref https://developer.apple.com/library/prerelease/ios/#releasenotes/General/RN-iOSSDK-6_0/_index.html
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    // [super didReceiveMemoryWarning] calls setView:nil
    [super didReceiveMemoryWarning];	
	// Release any cached data, images, etc that aren't in use.
}


#pragma mark -
// reference http://forums.macrumors.com/archive/index.php/t-512718.html
- (void)updateBackgroundColors {
    
    // class methods.  Do not instantiate an object.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    // use double instead of CGFloat.  On 32 bit iPhone, CGFloat is 32 bit, double is 64 bit.
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
    if (0 == [self.fromTemperatureUnitSegment selectedSegmentIndex])
        self.fromUnit = kBSUnitDegreeC;    
    if (1 == [self.fromTemperatureUnitSegment selectedSegmentIndex])
        self.fromUnit = kBSUnitDegreeF;    
    if (2 == [self.fromTemperatureUnitSegment selectedSegmentIndex])
        self.fromUnit = kBSUnitDegreeK;    
    if (3 == [self.fromTemperatureUnitSegment selectedSegmentIndex])
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
    if (0 == [self.toTemperatureUnitSegment selectedSegmentIndex])
        self.toUnit = kBSUnitDegreeC;    
    if (1 == [self.toTemperatureUnitSegment selectedSegmentIndex])
        self.toUnit = kBSUnitDegreeF;    
    if (2 == [self.toTemperatureUnitSegment selectedSegmentIndex])
        self.toUnit = kBSUnitDegreeK;    
    if (3 == [self.toTemperatureUnitSegment selectedSegmentIndex])
        self.toUnit = kBSUnitDegreeR;    
    
    // Convert model property temperatureK to view output units, then fill output label
    self.convertToField.text = [formatter stringFromNumber:
                                [self.converter convertTemperature:self.converter.temperatureK
                                                       fromKToUnit:self.toUnit]];
    
    
    // Display temperature tidbit
    self.temperatureTidbitLabel.text = [self.converter 
                                        tidbitForTemperatureK:self.converter.temperatureK];
    [self updateBackgroundColors];
}


#pragma mark - textFieldDelegate methods
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

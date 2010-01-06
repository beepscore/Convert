//
//  ConvertViewController.h
//  Convert
//
//  Created by Steve Baker on 1/5/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConvertViewController : UIViewController <UITextFieldDelegate> {
    UITextField *convertFromField;
    UILabel *convertToLabel;
    NSNumber *inputValue;
    NSNumber *outputValue;
}
#pragma mark -
#pragma mark properties

@property(nonatomic,retain)IBOutlet UITextField *convertFromField;
@property(nonatomic,retain)IBOutlet UILabel *convertToLabel;
@property(nonatomic,retain)NSNumber *inputValue;
@property(nonatomic,retain)NSNumber *outputValue;

@end

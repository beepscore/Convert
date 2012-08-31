//
//  ConvertAppDelegate.h
//  Convert
//
//  Created by Steve Baker on 1/5/10.
//  Copyright Beepscore LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConvertViewController;

@interface ConvertAppDelegate : NSObject <UIApplicationDelegate> {
    // Xcode automatically adds instance variables to back properties
}
#pragma mark - properties
@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet ConvertViewController *viewController;

@end


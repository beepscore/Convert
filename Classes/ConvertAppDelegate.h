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
    UIWindow *window;
    ConvertViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ConvertViewController *viewController;

@end


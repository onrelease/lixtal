//
//  LixtalAppDelegate.h
//  Lixtal
//
//  Created by Michael Jensen on 10/01/14.
//  Copyright (c) 2014 Michael Jensen. All rights reserved.
//


/*
#import <UIKit/UIKit.h>

@interface LixtalAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
*/



#import <UIKit/UIKit.h>

@class LixtalViewController;


@interface LixtalAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    LixtalViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet LixtalViewController *viewController;

@end

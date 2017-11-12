//
//  LixtalViewController.h
//  Lixtal
//
//  Created by Michael Jensen on 10/01/14.
//  Copyright (c) 2014 Michael Jensen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LixtalBrain.h"


@interface LixtalViewController : UIViewController <UITextViewDelegate>
{
	
    IBOutlet UITextView *inputfield;
    IBOutlet UITextView *textinfo;
	LixtalBrain *model;
}

@property (strong, nonatomic) IBOutlet UITextView *inputfield;
@property (strong, nonatomic) IBOutlet UITextView *textinfo;


- (IBAction)runLix:(id)sender;
- (IBAction)trimText:(id)sender;
- (IBAction)clearText:(id)sender;
- (IBAction)aboutLix:(id)sender;


@end

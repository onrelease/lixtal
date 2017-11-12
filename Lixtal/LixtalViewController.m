//
//  LixtalViewController.m
//  Lixtal
//
//  Created by Michael Jensen on 10/01/14.
//  Copyright (c) 2014 Michael Jensen. All rights reserved.
//

#import "LixtalViewController.h"

@interface LixtalViewController ()

@end

@implementation LixtalViewController
@synthesize inputfield = _inputfield;
@synthesize textinfo = _textinfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _inputfield.delegate = self;
    
    model = [[LixtalBrain alloc] init];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)runLix:(id)sender {
    
    // If no input, show default text
    if(_inputfield.text.length<1){
        _inputfield.text = @"Indsæt tekst her...";
    } else {
        
        NSArray* foo = [[model lix:(_inputfield.text)] componentsSeparatedByString: @"###"];
        NSString* outputLixtal = [foo objectAtIndex: 0];
        NSString* outputLixinfo = [foo objectAtIndex: 1];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: outputLixtal
                                                       message: outputLixinfo
                                                      delegate: self
                                             cancelButtonTitle:@"Ok"
                                             otherButtonTitles:nil];
        
        
        [alert show];
        
        
    }
    
    // Hide keyboard
    [_inputfield resignFirstResponder];
}

- (IBAction)trimText:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Trim Tekst"
                                                   message: @"Denne funktion fjerner alle overflødige specialtegn, emailadresser, url'er etc. i teksten, således et mere korrekt lixtal fremgår. Når du har trimmet teksten kan du beregne et nyt lixtal."
                                                  delegate: self
                                         cancelButtonTitle:@"Annuller"
                                         otherButtonTitles:@"Ok",nil];
    
    
    [alert show];
    //[alert release];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        // NSLog(@"user pressed Button Indexed 0");
    }
    else
    {
        // NSLog(@"user pressed Button Indexed 1");
        _inputfield.text = [NSString stringWithFormat:@"%@", [model trim:(_inputfield.text)]];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([_inputfield isFirstResponder] && [touch view] != _inputfield) {
        [_inputfield resignFirstResponder];
        
        if ([_inputfield.text isEqualToString:@""]) {
            _inputfield.text = @"Indsæt tekst her...";
        }
    }
    
    [super touchesBegan:touches withEvent:event];
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    [textView setSelectedRange:NSMakeRange(0, textView.text.length)];
    
    if ([textView.text isEqualToString:@"Indsæt tekst her..."] || [textView.text isEqualToString:@"Indsæt tekst her."]) {
        [textView setText:@""];
    }
    
    return YES;
}



- (IBAction)clearText:(id)sender {
    _inputfield.text = @"";
    [model clearCounts];
}



- (IBAction)aboutLix:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Lixtal"
                                                   message: @"Beregneren er udviklet af \nInteractive Developing ApS \nv/Michael Jensen \nHøjskolevej 6, Snoghøj \nDK-7000 Fredericia \nwww.interactivedeveloping.com \ncontact@interactivedeveloping.com"
                                                  delegate: self
                                         cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
    
    [alert show];
    
    [_inputfield resignFirstResponder];
}


@end

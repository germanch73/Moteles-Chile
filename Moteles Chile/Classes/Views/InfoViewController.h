//
//  InfoViewController.h
//  Moteles Chile
//
//  Created by Germán on 26-07-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface InfoViewController : ViewController<MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *mailButton;

- (IBAction)mail;
- (IBAction)web1;
- (IBAction)web2;
- (IBAction)facebook;
- (IBAction)close;
- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer;

@end
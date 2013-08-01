//
//  CreditsViewController.m
//  Moteles Chile
//
//  Created by Germán on 26-07-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "CreditsViewController.h"

@interface CreditsViewController () {
    float _initialScale;
}

@end

@implementation CreditsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"Credits";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - View actions

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _initialScale = recognizer.scale;
    } else {
        if (_initialScale < recognizer.scale) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

@end

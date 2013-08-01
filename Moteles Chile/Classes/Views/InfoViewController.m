//
//  InfoViewController.m
//  Moteles Chile
//
//  Created by Germán on 26-07-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "InfoViewController.h"
#import "CreditsViewController.h"

@interface InfoViewController () {
    float _initialScale;
}

@end

@implementation InfoViewController

@synthesize mailButton = _mailButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"Info";
    
    self.mailButton.enabled = [MFMailComposeViewController canSendMail];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - View actions

- (IBAction)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)mail
{
    MFMailComposeViewController* viewController = [[MFMailComposeViewController alloc] init];
    
    viewController.mailComposeDelegate = self;
    [viewController setToRecipients:[NSArray arrayWithObjects:@"contacto@naranjasoftware.cl", nil]];
    viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)web1
{
    NSURL *url = [NSURL URLWithString:@"http://www.naranjasoftware.cl"];
    
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)web2
{
    NSURL *url = [NSURL URLWithString:@"http://www.motelesapp.com"];
    
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)facebook
{
    NSURL *url = [NSURL URLWithString:@"http://www.facebook.com/naranjasoftware"];
    
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _initialScale = recognizer.scale;
    } else {
        if (_initialScale > recognizer.scale) {
            UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Credits"];
            
            viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
            [self presentViewController:viewController animated:YES completion:nil];
        }
    }
}

#pragma mark - Mail Compose delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

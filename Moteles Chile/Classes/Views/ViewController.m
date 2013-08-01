//
//  ViewController.m
//  Moteles Chile
//
//  Created by German Chavez on 28-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

- (void)showInfo;
- (void)goHome;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = VIEW_COLOR;
    
    int count = self.navigationController.viewControllers.count;
    
    if (count > 2) {
        UIButton *homeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        
        [homeButton setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
        homeButton.showsTouchWhenHighlighted = NO;
        [homeButton addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *homeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:homeButton];
        
        self.navigationItem.rightBarButtonItem = homeButtonItem;
    /*} else {
        UIButton *infoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [infoButton setImage:[UIImage imageNamed:@"Info"] forState:UIControlStateNormal];
        [infoButton addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
     
        UIBarButtonItem *infoButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
        
        self.navigationItem.rightBarButtonItem = infoButtonItem;*/
    }
}

- (void)showInfo
{
    /*InfoViewController *viewController = [[InfoViewController alloc] initWithNibName:@"InfoView" bundle:nil];
    viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:viewController animated:YES];*/
}

- (void)goHome
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                          
    [self.navigationController popToViewController:delegate.menuViewController animated:YES];
}

@end

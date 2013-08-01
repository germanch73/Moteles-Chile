//
//  MenuViewController.m
//  Moteles Chile
//
//  Created by German Chavez on 28-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "MenuViewController.h"
#import "InfoViewController.h"

@interface MenuViewController ()

- (void)showInfo;

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"Menu";
    
    self.title = @"Moteles";
    
    UIImage *image = [UIImage imageNamed:@"logo"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    
    self.navigationItem.leftBarButtonItem = buttonItem;
    
    UIButton *infoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [infoButton setImage:[UIImage imageNamed:@"info"] forState:UIControlStateNormal];
    infoButton.showsTouchWhenHighlighted = NO;
    [infoButton addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *infoButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    
    self.navigationItem.rightBarButtonItem = infoButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)showInfo
{
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Info"];
    
    viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)goLocality;
{
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Locality"];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)goNear
{
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Near"];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)goPrice
{
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Price"];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)goServices
{
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Services"];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)goComments
{
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Comments"];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)goPromotions
{
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Promotions"];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)goFeatured
{
    
}

- (IBAction)goSearch
{
    
}

- (IBAction)goSettings
{
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Settings"];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

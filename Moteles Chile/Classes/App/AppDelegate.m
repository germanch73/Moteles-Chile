//
//  AppDelegate.m
//  Moteles Chile
//
//  Created by German Chavez on 28-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "AppDelegate.h"
#import "GAI.h"
#import "GAITracker.h"
#import "LoadingViewController.h"

@implementation AppDelegate

- (void)customizeAppearance
{
    UIImage *navigationBarImage = [UIImage imageWithColor:[UIColor colorWithRed:110.0/255.0 green:0 blue:127.0/255.0 alpha:0.95]];

    [[UINavigationBar appearance] setBackgroundImage:navigationBarImage
                                       forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:navigationBarImage
                                       forBarMetrics:UIBarMetricsLandscapePhone];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor, [UIColor clearColor], UITextAttributeTextShadowColor, [UIFont fontWithName:@"Helvetica Neue" size:19], UITextAttributeFont, nil]];
    
    UIImage *buttonImage = [UIImage imageWithColor:[UIColor clearColor]];
    [[UIBarButtonItem appearance] setBackgroundImage:buttonImage
                                            forState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:buttonImage
                                            forState:UIControlStateNormal
                                          barMetrics:UIBarMetricsLandscapePhone];
    
    UIImage *backButton30 = [[UIImage imageNamed:@"back-button30"]
                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 5)];
    UIImage *backButton24 = [[UIImage imageNamed:@"back-button24"]
                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 5)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton30
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton24
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsLandscapePhone];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor, [UIColor clearColor], UITextAttributeTextShadowColor, [UIFont fontWithName:@"Helvetica Neue" size:15], UITextAttributeFont, nil] forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor redColor], UITextAttributeTextColor, [UIColor clearColor], UITextAttributeTextShadowColor, [UIFont fontWithName:@"Helvetica Neue" size:15], UITextAttributeFont, nil] forState:UIControlStateDisabled];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor grayColor], UITextAttributeTextColor, [UIColor clearColor], UITextAttributeTextShadowColor, [UIFont fontWithName:@"Helvetica Neue" size:15], UITextAttributeFont, nil] forState:UIControlStateHighlighted];
    
    UIImage *searchBarImage = [UIImage imageWithHeight:44 color:[UIColor colorWithRed:171.0/255.0 green:0 blue:250.0/255.0 alpha:1] bottomColor:[UIColor colorWithRed:137.0/255.0 green:0 blue:202.0/255.0 alpha:1]];
    [[UISearchBar appearance] setBackgroundImage:searchBarImage];
    
    //UIImage *toolBarImage = [UIImage imageWithColor:[UIColor colorWithRed:110.0/255.0 green:0 blue:127.0/255.0 alpha:0.85]];
    
    //[[UIToolbar appearance] setBackgroundImage:toolBarImage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    //[[UIToolbar appearance] setBackgroundImage:toolBarImage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsLandscapePhone];
    
    UIImage *segmentUnselected = [UIImage imageNamed:@"segment-unselected"];
    UIImage *segmentSelected = [UIImage imageNamed:@"segment-selected"];
    UIImage *segmentUnselectedUnselected = [UIImage imageNamed:@"segment-unselected-unselected"];
    UIImage *segmentSelectedUnselected = [UIImage imageNamed:@"segment-selected-unselected"];
    UIImage *segmentUnselectedSelected = [UIImage imageNamed:@"segment-unselected-selected"];
    
    [[UISegmentedControl appearance] setBackgroundImage:segmentUnselected
                                               forState:UIControlStateNormal
                                             barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setBackgroundImage:segmentSelected
                                               forState:UIControlStateSelected
                                             barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:segmentUnselectedUnselected
                                 forLeftSegmentState:UIControlStateNormal
                                   rightSegmentState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:segmentSelectedUnselected
                                 forLeftSegmentState:UIControlStateSelected
                                   rightSegmentState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:segmentUnselectedSelected
                                 forLeftSegmentState:UIControlStateNormal
                                   rightSegmentState:UIControlStateSelected
                                          barMetrics:UIBarMetricsDefault];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor, [UIColor clearColor], UITextAttributeTextShadowColor, [UIFont fontWithName:@"Helvetica Neue" size:13], UITextAttributeFont, nil] forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor colorWithRed:110.0/255.0 green:0 blue:127.0/255.0 alpha:1], UITextAttributeTextColor, [UIColor clearColor], UITextAttributeTextShadowColor, [UIFont fontWithName:@"Helvetica Neue" size:13], UITextAttributeFont, nil] forState:UIControlStateSelected];
    
    /*buttonImage = [[UIImage imageNamed:@"button"]
                   resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [[UIButton appearance] setImage:buttonImage forState:UIControlStateNormal];
    [[UIButton appearance] setImage:buttonImage forState:UIControlStateSelected];
    [[UIButton appearance] setImage:buttonImage forState:UIControlStateHighlighted];
    [[UIButton appearance] setImage:buttonImage forState:UIControlStateDisabled];*/
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self customizeAppearance];
    
    self.navigationController = (UINavigationController *)self.window.rootViewController;
    
    LoadingViewController *viewController = [self.navigationController.viewControllers objectAtIndex:0];
    
    viewController.loadDelegate = self;
    
    [self.window makeKeyAndVisible];
    
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    [GAI sharedInstance].debug = YES;
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-42084092-1"];
    [GAI sharedInstance].defaultTracker = tracker;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)dataDidFinishLoading
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    
    self.menuViewController = viewController;
    
    [self.navigationController pushViewController:viewController animated:NO];
}

@end

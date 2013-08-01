//
//  AppDelegate.h
//  Moteles Chile
//
//  Created by German Chavez on 28-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, LoadDataDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) UIViewController *menuViewController;

@end

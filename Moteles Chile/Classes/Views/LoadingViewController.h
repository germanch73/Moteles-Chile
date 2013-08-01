//
//  LoadingViewController.h
//  Moteles Chile
//
//  Created by German Chavez on 28-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@protocol LoadDataDelegate;

@interface LoadingViewController : ViewController<CLLocationManagerDelegate>

@property (strong, nonatomic) id<LoadDataDelegate> loadDelegate;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;

@end

@protocol LoadDataDelegate <NSObject>

@required

- (void)dataDidFinishLoading;

@end

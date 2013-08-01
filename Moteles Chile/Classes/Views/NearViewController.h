//
//  NearViewController.h
//  Moteles Chile
//
//  Created by German Chavez on 28-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "HotelsViewController.h"
#import <MapKit/MapKit.h>

@interface NearViewController : TableViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) CLLocation *fixedLocation;

@property (strong, nonatomic) IBOutlet UISegmentedControl *viewTypeSegmentedControl;

- (IBAction)viewTypeChanged;

@end

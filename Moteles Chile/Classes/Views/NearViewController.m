//
//  NearViewController.m
//  Moteles Chile
//
//  Created by German Chavez on 28-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "NearViewController.h"
#import "HotelCell.h"
#import "HotelViewController.h"

@interface NearViewController () {
    NSMutableArray *_data;
    CLLocationManager *_locationManager;
    CLLocation *_fixedLocation;
}

- (void)showTable;
- (void)showMap;
- (void)updateLocation:(CLLocation *)location;
- (void)updateDistances:(CLLocation *)location;
- (void)loadImagesForOnscreenRows;

@end

@implementation NearViewController

@synthesize containerView = _containerView;
@synthesize mapView = _mapView;
@synthesize fixedLocation = _fixedLocation;
@synthesize viewTypeSegmentedControl = _viewTypeSegmentedControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"Near";
    
    self.navigationController.navigationItem.prompt = @"Hola";
    
    [self addFooterView];
    
    self.tableView.rowHeight = HOTEL_HEIGHT;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger viewType = [prefs integerForKey:@"nearViewViewType"];
    
    self.viewTypeSegmentedControl.selectedSegmentIndex = viewType;
    
    if (viewType == 0) {
        [self.mapView removeFromSuperview];
    }
    
    if (self.fixedLocation) {
        [self updateLocation:self.fixedLocation];
        //self.locationView.image = [UIImage imageNamed:@"fixed-location"];
    }
    
    if (_fixedLocation) {
        [self updateDistances:_fixedLocation];
    } else {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 100.0;
        [_locationManager startUpdatingLocation];
    }
    
    if (_data.count) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        [self loadImagesForOnscreenRows];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_fixedLocation) {
        [self updateDistances:_fixedLocation];
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HotelCell";
    
    HotelCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HotelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    Hotel *hotel = [_data objectAtIndex:indexPath.row];
    
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    selectedBackgroundView.backgroundColor = SELECTION_COLOR;
    cell.selectedBackgroundView = selectedBackgroundView;
    
    cell.hotel = hotel;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Hotel *hotel = [_data objectAtIndex:indexPath.row];
    
    HotelViewController *viewController = (HotelViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"Hotel"];
    
    viewController.hotel = hotel;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

#pragma mark - View actions

- (IBAction)viewTypeChanged
{
    switch (self.viewTypeSegmentedControl.selectedSegmentIndex) {
        case 0:
            [self showTable];
            break;
            
        case 1:
            [self showMap];
            break;
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:self.viewTypeSegmentedControl.selectedSegmentIndex forKey:@"nearViewViewType"];
}

#pragma mark - Location Manager delegates

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (newLocation) {
        //_userLocation = newLocation;
        //_currentLocation = newLocation;
        
        if ((oldLocation.coordinate.latitude != newLocation.coordinate.latitude) ||
            (oldLocation.coordinate.longitude != newLocation.coordinate.longitude)) {
            [self updateDistances:newLocation];
            [self updateLocation:newLocation];
            
            /*if (!self.updated) {
                self.updated = YES;
                
                MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 3500, 3500);
                [self.mapView setRegion:region animated:YES];
            }*/
        }
        
        //[self updateButtons];
    }
}

#pragma mark - Private

- (void)showTable
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.containerView cache:YES];
	[self.mapView removeFromSuperview];
	[UIView commitAnimations];
}

- (void)showMap
{
    self.mapView.frame = self.tableView.frame;
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.containerView cache:YES];
	[self.containerView addSubview:self.mapView];
	[UIView commitAnimations];
}

- (void)updateLocation:(CLLocation *)location
{
    /*if (!self.geocoder) {
     self.geocoder = [[CLGeocoder alloc] init];
     }
     
     [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray* placemarks, NSError* error) {
     if ([placemarks count] > 0) {
     CLPlacemark *placemark = [placemarks objectAtIndex:0];
     
     self.locationLabel.text = [NSString stringWithFormat:@"Cerca de %@ %@", placemark.thoroughfare, placemark.subLocality];
     }
     }];*/
}

- (void)updateDistances:(CLLocation *)location
{
    NSMutableArray *hotels = [Data instance].activeHotels;
    
    float distance = 2000;
    
    _data = [[NSMutableArray alloc] initWithCapacity:hotels.count];
    
    for (Hotel *hotel in hotels) {
        CLLocation *point = [[CLLocation alloc] initWithLatitude:hotel.latitude longitude:hotel.longitude];
        
        hotel.distance = [point distanceFromLocation:location];
        
        if (hotel.distance <= distance) {
            [_data addObject:hotel];
        }
	}
    
    [_data sortUsingComparator:(NSComparator)^(id obj1, id obj2) {
        const Hotel *hotel1 = (const Hotel *)obj1;
        const Hotel *hotel2 = (const Hotel *)obj2;
        double distance1 = hotel1.distance;
        double distance2 = hotel2.distance;
        if (distance1 < distance2)
            return NSOrderedAscending;
        if (distance1 > distance2)
            return NSOrderedDescending;
        return NSOrderedSame;
    }];
    
    [self.tableView reloadData];
    [self loadImagesForOnscreenRows];
    
    //[self.mapView removeAnnotations:self.annotations];
    
    //self.annotations = [NSMutableArray arrayWithCapacity:self.data.count];
    //for (Hotel *hotel in self.data) {
    //    HotelAnnotation *annotation = [[HotelAnnotation alloc]  init];
    //    annotation.hotel = hotel;
    //    [self.annotations addObject:annotation];
	//}
    //[self.mapView addAnnotations:self.annotations];
}

- (void)loadImagesForOnscreenRows
{
    if (_data.count > 0) {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths) {
            HotelCell *cell = (HotelCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            if (!cell.hotel.isIconLoading && !cell.hotel.isIconLoaded) {
                [cell.hotel downloadIcon];
            }
        }
    }
}

@end

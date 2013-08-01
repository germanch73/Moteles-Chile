//
//  HotelsViewController.m
//  Moteles Chile
//
//  Created by German Chavez on 30-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "HotelsViewController.h"
#import "HotelCell.h"
#import "HotelViewController.h"

@interface HotelsViewController () {
    NSMutableArray *_filteredData;
    NSString *_savedSearchTerm;
    BOOL _searchWasActive;
    CLLocationManager *_locationManager;
}

- (void)updateDistances:(CLLocation *)location;
- (void)loadImagesForOnscreenRows;
- (void)sortBy:(int)field;
- (void)sortByPrice;
- (void)sortByDistance;
- (void)sortByRating;
- (void)sortByServices;
- (void)filterContentForSearchText:(NSString*)searchText;

@end

@implementation HotelsViewController

@synthesize header = _header;
@synthesize data = _data;
@synthesize sortBySegmentedControl = _sortBySegmentedControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"Hotels";
    
    [self addFooterView];
    
    self.title = _header;
    
    self.tableView.rowHeight = HOTEL_HEIGHT;
    
    _filteredData = [NSMutableArray arrayWithCapacity:_data.count];
    
    if (_savedSearchTerm) {
        [self.searchDisplayController setActive:_searchWasActive];
        [self.searchDisplayController.searchBar setText:_savedSearchTerm];
        
        _savedSearchTerm = nil;
    }
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 100.0;
    [_locationManager startUpdatingLocation];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger sortField = [prefs integerForKey:@"hotelViewSortField"];
    
    [self sortBy:sortField];
    self.sortBySegmentedControl.selectedSegmentIndex = sortField;
    
    if (_data.count) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        [self loadImagesForOnscreenRows];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    _searchWasActive = [self.searchDisplayController isActive];
    _savedSearchTerm = [self.searchDisplayController.searchBar text];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_filteredData count];
    }
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
    
    Hotel *hotel = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        hotel = [_filteredData objectAtIndex:indexPath.row];
    } else {
        hotel = [_data objectAtIndex:indexPath.row];
    }
    
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    selectedBackgroundView.backgroundColor = SELECTION_COLOR;
    cell.selectedBackgroundView = selectedBackgroundView;
    
    cell.hotel = hotel;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Hotel *hotel = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        hotel = [_filteredData objectAtIndex:indexPath.row];
    } else {
        hotel = [_data objectAtIndex:indexPath.row];
    }
    
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

#pragma mark - Location Manager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (newLocation) {
        if ((oldLocation.coordinate.latitude != newLocation.coordinate.latitude) ||
            (oldLocation.coordinate.longitude != newLocation.coordinate.longitude)) {
            [self updateDistances:newLocation];
            if (self.sortBySegmentedControl.selectedSegmentIndex == 1) { // distance
                [self sortBy:self.sortBySegmentedControl.selectedSegmentIndex];
                
                [self.tableView reloadData];
                
                [self loadImagesForOnscreenRows];
            } else {
                [self.tableView reloadData];
            }
        }
    }
}

#pragma mark - View actions

- (IBAction)sortByChanged
{
    [self sortBy:self.sortBySegmentedControl.selectedSegmentIndex];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:self.sortBySegmentedControl.selectedSegmentIndex forKey:@"hotelViewSortField"];
    
    [self loadImagesForOnscreenRows];
}

#pragma Private

- (void)updateDistances:(CLLocation *)location
{
    for (Hotel *hotel in _data) {
        CLLocation *point = [[CLLocation alloc] initWithLatitude:hotel.latitude longitude:hotel.longitude];
        
        hotel.distance = [point distanceFromLocation:location];
	}
}

- (void)loadImagesForOnscreenRows
{
    NSMutableArray *data = [self.searchDisplayController isActive] ? _filteredData : _data;
    UITableView *tableView = [self.searchDisplayController isActive] ? self.searchDisplayController.searchResultsTableView : self.tableView;
    
    if (data.count > 0) {
        NSArray *visiblePaths = [tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths) {
            HotelCell *cell = (HotelCell *)[tableView cellForRowAtIndexPath:indexPath];
            if (!cell.hotel.isIconLoading && !cell.hotel.isIconLoaded) {
                [cell.hotel downloadIcon];
            }
        }
    }
}

- (void)sortBy:(int)field
{
    switch (field) {
        case 0:
            [self sortByPrice];
            break;
            
        case 1:
            [self sortByDistance];
            break;
            
        case 2:
            [self sortByRating];
            break;
            
        case 3:
            [self sortByServices];
            break;
            
        default:
            return;
    }
    
    [self.tableView reloadData];
}

- (void)sortByPrice
{
    [_data sortUsingComparator:(NSComparator)^(id obj1, id obj2) {
        const Hotel *hotel1 = (const Hotel *)obj1;
        const Hotel *hotel2 = (const Hotel *)obj2;
        if (hotel1.price == 0 && hotel2.price == 0)
            return NSOrderedSame;
        if (hotel1.price == 0)
            return NSOrderedDescending;
        if (hotel2.price == 0)
            return NSOrderedAscending;
        if (hotel1.price < hotel2.price)
            return NSOrderedAscending;
        if (hotel1.price > hotel2.price)
            return NSOrderedDescending;
        return NSOrderedSame;
    }];
}

- (void)sortByDistance
{
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
}

- (void)sortByRating
{
    [_data sortUsingComparator:(NSComparator)^(id obj1, id obj2) {
        const Hotel *hotel1 = (const Hotel *)obj1;
        const Hotel *hotel2 = (const Hotel *)obj2;
        if (hotel1.rating > hotel2.rating)
            return NSOrderedAscending;
        if (hotel1.rating < hotel2.rating)
            return NSOrderedDescending;
        if (hotel1.valorations > hotel2.valorations)
            return NSOrderedAscending;
        if (hotel1.valorations < hotel2.valorations)
            return NSOrderedDescending;
        return NSOrderedSame;
    }];
}

- (void)sortByServices
{
    [_data sortUsingComparator:(NSComparator)^(id obj1, id obj2) {
        const Hotel *hotel1 = (const Hotel *)obj1;
        const Hotel *hotel2 = (const Hotel *)obj2;
        if (hotel1.services > hotel2.services)
            return NSOrderedAscending;
        if (hotel1.services < hotel2.services)
            return NSOrderedDescending;
        return NSOrderedSame;
    }];
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText
{
	[_filteredData removeAllObjects];
    
	for (Hotel *hotel in _data) {
        NSRange range = [hotel.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (range.length > 0) {
            [_filteredData addObject:hotel];
        } else {
            range = [hotel.address rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.length > 0) {
                [_filteredData addObject:hotel];
            } else {
                range = [hotel.locality rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (range.length > 0) {
                    [_filteredData addObject:hotel];
                }
            }
        }
	}
    
    [self loadImagesForOnscreenRows];
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    tableView.rowHeight = HOTEL_HEIGHT;
    tableView.backgroundColor = self.tableView.backgroundColor;
    tableView.separatorColor = self.tableView.separatorColor;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    
    for (UIView* view in self.searchDisplayController.searchResultsTableView.subviews) {
        if ([view isKindOfClass: [UILabel class]] &&
            [[(UILabel*)view text] isEqualToString:@"No Results"]) {
            [(UILabel *)view setText:@"Ningún Resultado"];
            [(UILabel *)view setTextColor:[UIColor whiteColor]];
            break;
        }
    }
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]];
    
    return YES;
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    [self.searchDisplayController.searchBar setShowsCancelButton:YES animated:NO];
    
    for (UIView *view in self.searchDisplayController.searchBar.subviews) {
        if ([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            [(UIBarItem *)view setTitle:@"Cancelar"];
        }
    }
}

@end

//
//  RegionFilterViewController.m
//  Moteles Chile
//
//  Created by German Chavez on 01-07-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "RegionFilterViewController.h"

@interface RegionFilterViewController () {
    NSMutableArray *_data;
}

@end

@implementation RegionFilterViewController

@synthesize filterDelegate = _filterDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"RegionFilter";
	
    _data = [NSMutableArray arrayWithArray:[Data instance].regions];
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
    static NSString *CellIdentifier = @"RegionFilterCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    Region *region = [_data objectAtIndex:indexPath.row];
    
    cell.textLabel.text = region.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", region.hotels.count];

    UIImage *image = (region.code == [Data instance].activeRegion.code) ? [UIImage imageNamed:@"check"] : [UIImage imageNamed:@"uncheck"];
    cell.imageView.image = image;
    
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    selectedBackgroundView.backgroundColor = SELECTION_COLOR;
    cell.selectedBackgroundView = selectedBackgroundView;
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textColor = TEXT_COLOR;
    cell.detailTextLabel.textColor = DETAIL_TEXT_COLOR;
    
    cell.textLabel.font = TEXT_FONT;
    cell.detailTextLabel.font = DETAIL_TEXT_FONT;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Region *region = [_data objectAtIndex:indexPath.row];
    [Data instance].activeRegion = region;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:region.code forKey:@"activeRegion"];
    
    [self.tableView reloadData];

    if (self.filterDelegate) {
        [self.filterDelegate filterChange:region];
    }
}

@end

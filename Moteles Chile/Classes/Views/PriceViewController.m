//
//  PriceViewController.m
//  Moteles Chile
//
//  Created by German Chavez on 28-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "PriceViewController.h"
#import "HotelsViewController.h"

@interface PriceViewController () {
    NSMutableArray *_data;
}

@end

@implementation PriceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"Price";
    
    _data = [Data instance].activePrices;
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
    static NSString *CellIdentifier = @"PriceCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    Price *price = [_data objectAtIndex:indexPath.row];
    
    cell.textLabel.text = price.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", price.hotels.count];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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
    Price *price = [_data objectAtIndex:indexPath.row];
    
    HotelsViewController *viewController = (HotelsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"Hotels"];
    
    viewController.header = price.name;
    viewController.data = price.hotels;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

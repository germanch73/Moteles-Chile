//
//  ServicesViewController.m
//  Moteles Chile
//
//  Created by German Chavez on 28-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "ServicesViewController.h"
#import "HotelsViewController.h"

@interface ServicesViewController () {
    NSMutableArray *_data;
    int _services;
}

- (void)updateFilter;

@end

@implementation ServicesViewController

@synthesize filterButton = _filterButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"Services";
    
    [self addFooterView];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    _services = [prefs integerForKey:@"servicesViewFilter"];
    
    _data = [Data instance].activeServices;
    
    [self updateFilter];
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
    static NSString *CellIdentifier = @"ServiceCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    Service *service = [_data objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage explodeImageWithImage:service.icon width:88 height:88];
    cell.textLabel.text = service.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", service.count];
    
    UIImage *image = (service.code & _services) ? [UIImage imageNamed:@"checked.png"] : [UIImage imageNamed:@"unchecked.png"];
    cell.accessoryView = [[UIImageView alloc] initWithImage:image];
    
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Service *service = [_data objectAtIndex:indexPath.row];
    
    if (service.code & _services) {
        _services &= ~service.code;
    } else {
        _services |= service.code;
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:_services forKey:@"servicesViewFilter"];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)cell.accessoryView;
    
    UIImage *newImage = (service.code & _services) ? [UIImage imageNamed:@"checked.png"] : [UIImage imageNamed:@"unchecked.png"];
    
    imageView.image = newImage;
    
    [self updateFilter];
}

#pragma mark - private

 - (void)updateFilter
{
    int selected = 0;
    int unselected = 0;
    for (Service *service in _data) {
        if (service.code & _services) {
            selected++;
        } else {
            unselected++;
        }
    }
    
    NSMutableArray *hotels = [Data instance].activeHotels;
    
    int filtered = 0;
    if (_services) {
        for (Hotel *hotel in hotels) {
            if ((hotel.services & _services) == _services) {
                filtered++;
            }
        }
    }
    
    if (filtered) {
        if (filtered == 1) {
            //self.filterButton.titleLabel.text = @"ver el motel";
            [self.filterButton setTitle:@"ver el motel" forState:UIControlStateNormal];
        } else {
            //self.filterButton.titleLabel.text = [NSString stringWithFormat:@"ver los %d moteles", filtered];
            [self.filterButton setTitle:[NSString stringWithFormat:@"ver los %d moteles", filtered] forState:UIControlStateNormal];
        }
    } else {
        //self.filterButton.titleLabel.text = @"Ninguno";
        [self.filterButton setTitle:@"Ninguno" forState:UIControlStateDisabled];
    }
    self.filterButton.enabled = filtered > 0;
}

- (IBAction)filter
{
    NSString *header = nil;
    for (Service *service in _data) {
        if (service.code & _services) {
            if (header) {
                header = @"Varios";
                break;
            } else {
                header = service.name;
            }
        }
    }
    
    HotelsViewController *viewController = (HotelsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"Hotels"];
    
    viewController.header = header;
    viewController.data = [[NSMutableArray alloc] init];
    
    NSMutableArray *hotels = [[Data instance] hotels];
    
    for (Hotel *hotel in hotels) {
        if ((hotel.services & _services) == _services) {
            [viewController.data addObject:hotel];
        }
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

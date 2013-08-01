//
//  SettingsViewController.m
//  Moteles Chile
//
//  Created by Germán on 28-07-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "SettingsViewController.h"

typedef enum {
    RegionSection,
    SectionCount,
} Section;

typedef enum {
    RegionRowRegion,
    RegionRowCount,
} RegionRow;

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"Settings";
    
    //[self.tableView setBackgroundView:nil];
    //[self.tableView setBackgroundView:[[UIView alloc] init]];
    //[self.tableView setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return SectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case RegionSection:
            return RegionRowCount;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == RegionSection) {
        static NSString *CellIdentifier = @"RegionCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"Región";
        cell.detailTextLabel.text = [Data instance].activeRegion.name;
    }
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case RegionSection:
            switch (indexPath.row) {
                case RegionRowRegion: {
                        RegionFilterViewController *viewController = (RegionFilterViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"RegionFilter"];
                    
                        viewController.filterDelegate = self;
                    
                        [self.navigationController pushViewController:viewController animated:YES];
                    }
                    break;
            }
            break;
    }
}

#pragma mark Regions Filter delegate

- (void)filterChange:(Region *)region
{
    [self.tableView reloadData];
}

@end

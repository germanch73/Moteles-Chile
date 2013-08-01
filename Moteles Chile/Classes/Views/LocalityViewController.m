//
//  LocalityViewController.m
//  Moteles Chile
//
//  Created by German Chavez on 28-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "LocalityViewController.h"
#import "HotelsViewController.h"

@interface LocalityViewController () {
    NSMutableArray *_data;
    NSMutableArray *_filteredData;
    NSString *_savedSearchTerm;
    BOOL _searchWasActive;
}

- (void)filterContentForSearchText:(NSString*)searchText;

@end

@implementation LocalityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"Locality";
    
    _data = [Data instance].activeLocalities;
    
    _filteredData = [NSMutableArray arrayWithCapacity:_data.count];
    
    if (_savedSearchTerm) {
        [self.searchDisplayController setActive:_searchWasActive];
        [self.searchDisplayController.searchBar setText:_savedSearchTerm];
        
        _savedSearchTerm = nil;
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
    static NSString *CellIdentifier = @"LocalityCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    Locality *locality = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        locality = [_filteredData objectAtIndex:indexPath.row];
    } else {
        locality = [_data objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = locality.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", locality.hotels.count];
    
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
    Locality *locality = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        locality = [_filteredData objectAtIndex:indexPath.row];
    } else {
        locality = [_data objectAtIndex:indexPath.row];
    }
    
    HotelsViewController *viewController = (HotelsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"Hotels"];
    
    viewController.header = locality.name;
    viewController.data = locality.hotels;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText
{
	[_filteredData removeAllObjects];
    
	for (Locality *locality in _data) {
        NSRange range = [locality.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (range.length > 0) {
            [_filteredData addObject:locality];
        }
	}
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
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

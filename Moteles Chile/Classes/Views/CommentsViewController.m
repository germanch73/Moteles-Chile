//
//  CommentsViewController.m
//  Moteles Chile
//
//  Created by Germán on 26-07-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "CommentsViewController.h"
#import "HotelViewController.h"
#import "CommentCell.h"

@interface CommentsViewController () {
    NSMutableArray *_data;
}

- (void)sortBy:(int)field;
- (void)sortByDate;
- (void)sortByValoration;
- (void)sortByHotel;

@end

@implementation CommentsViewController

@synthesize sortBySegmentedControl = _sortBySegmentedControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"Comments";
    
    [self addFooterView];
    
    _data = [Data instance].activeComments;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger sortField = [prefs integerForKey:@"commentsViewSortField"];
    
    [self sortBy:sortField];
    self.sortBySegmentedControl.selectedSegmentIndex = sortField;
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
    static NSString *CellIdentifier = @"CommentCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Comment *comment = [_data objectAtIndex:indexPath.row];
    
    ((CommentCell *)cell).comment = comment;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    selectedBackgroundView.backgroundColor = SELECTION_COLOR;
    cell.selectedBackgroundView = selectedBackgroundView;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comment *comment = [_data objectAtIndex:indexPath.row];
    
    float width = tableView.bounds.size.width - 20;
    
    CGSize maximumLabelSize = CGSizeMake(width, 9999);
    
    CGSize size = [comment.description sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:14] constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    
    float height = 5 + 15 + 23 + size.height + 5;
    
    return height + 2;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comment *comment = [_data objectAtIndex:indexPath.row];
    
    HotelViewController *viewController = (HotelViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"Hotel"];
    
    viewController.hotel = comment.hotel;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - View actions

- (IBAction)sortByChanged
{
    [self sortBy:self.sortBySegmentedControl.selectedSegmentIndex];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:self.sortBySegmentedControl.selectedSegmentIndex forKey:@"commentsViewSortField"];
}

#pragma Private

- (void)sortBy:(int)field
{
    switch (field) {
        case 0:
            [self sortByDate];
            break;
            
        case 1:
            [self sortByValoration];
            break;

        case 2:
            [self sortByHotel];
            break;
            
        default:
            break;
    }
    
    [self.tableView reloadData];
}

- (void)sortByDate
{
    [_data sortUsingComparator:(NSComparator)^(id obj1, id obj2) {
        const Comment *comment1 = (const Comment *)obj1;
        const Comment *comment2 = (const Comment *)obj2;
        if (comment1.date > comment2.date)
            return NSOrderedAscending;
        if (comment1.date < comment2.date)
            return NSOrderedDescending;
        /*if (comment1.rating > comment2.rating)
            return NSOrderedAscending;
        if (comment1.rating < comment2.rating)
            return NSOrderedDescending;*/
        return NSOrderedSame;
    }];
}

- (void)sortByValoration
{
    [_data sortUsingComparator:(NSComparator)^(id obj1, id obj2) {
        const Comment *comment1 = (const Comment *)obj1;
        const Comment *comment2 = (const Comment *)obj2;
        if (comment1.rating > comment2.rating)
            return NSOrderedAscending;
        if (comment1.rating < comment2.rating)
            return NSOrderedDescending;
        /*if (comment1.date > comment2.date)
            return NSOrderedAscending;
        if (comment1.date < comment2.date)
            return NSOrderedDescending;*/
        return NSOrderedSame;
    }];
}

- (void)sortByHotel
{
    [_data sortUsingComparator:(NSComparator)^(id obj1, id obj2) {
        const Comment *comment1 = (const Comment *)obj1;
        const Comment *comment2 = (const Comment *)obj2;
        NSComparisonResult result = [comment1.hotel.name caseInsensitiveCompare:comment2.hotel.name];
        /*if (result == NSOrderedSame) {
            if (comment1.date > comment2.date)
                return NSOrderedAscending;
            if (comment1.date < comment2.date)
                return NSOrderedDescending;
            if (comment1.rating > comment2.rating)
                return NSOrderedAscending;
            if (comment1.rating < comment2.rating)
                return NSOrderedDescending;
        }*/
        return result;
    }];
}

@end

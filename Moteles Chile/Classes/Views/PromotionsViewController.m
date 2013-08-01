//
//  PromotionsViewController.m
//  Moteles Chile
//
//  Created by German Chavez on 30-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "PromotionsViewController.h"

@interface PromotionsViewController ()

@end

@implementation PromotionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"Promotions";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LocalityCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    //UI *ui = [UI instance];
    //cell.backgroundColor = [UIColor colorWithPatternImage:ui.tableCellImage];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end

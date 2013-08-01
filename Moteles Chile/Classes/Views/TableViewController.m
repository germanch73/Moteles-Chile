//
//  TableViewController.m
//  Moteles Chile
//
//  Created by German Chavez on 30-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = TABLE_COLOR;
    self.tableView.separatorColor = SEPARATOR_COLOR;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)addFooterView
{
    if (!self.tableView.tableFooterView ) {
        float width = self.view.bounds.size.width;
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, width, 0, 44)];
        footerView.backgroundColor = [UIColor clearColor];
        self.tableView.tableFooterView = footerView;
    }
}

@end

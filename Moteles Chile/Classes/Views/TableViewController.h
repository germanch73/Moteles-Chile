//
//  TableViewController.h
//  Moteles Chile
//
//  Created by German Chavez on 30-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "ViewController.h"

@interface TableViewController : ViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (void)addFooterView;

@end

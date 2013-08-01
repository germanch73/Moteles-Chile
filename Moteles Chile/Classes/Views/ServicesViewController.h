//
//  ServicesViewController.h
//  Moteles Chile
//
//  Created by German Chavez on 28-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "TableViewController.h"

@interface ServicesViewController : TableViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *filterButton;

- (IBAction)filter;

@end

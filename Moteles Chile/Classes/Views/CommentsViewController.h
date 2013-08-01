//
//  CommentsViewController.h
//  Moteles Chile
//
//  Created by Germán on 26-07-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "TableViewController.h"

@interface CommentsViewController : TableViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *sortBySegmentedControl;

- (IBAction)sortByChanged;

@end

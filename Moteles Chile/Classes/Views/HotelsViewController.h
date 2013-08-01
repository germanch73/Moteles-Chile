//
//  HotelsViewController.h
//  Moteles Chile
//
//  Created by German Chavez on 30-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "TableViewController.h"
#import <MapKit/MapKit.h>

@interface HotelsViewController : TableViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) NSString *header;
@property (strong, nonatomic) NSMutableArray *data;

@property (strong, nonatomic) IBOutlet UISegmentedControl *sortBySegmentedControl;

- (IBAction)sortByChanged;

@end

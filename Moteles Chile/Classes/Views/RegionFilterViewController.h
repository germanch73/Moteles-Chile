//
//  RegionFilterViewController.h
//  Moteles Chile
//
//  Created by German Chavez on 01-07-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "TableViewController.h"

@protocol RegionFilterDelegate;

@interface RegionFilterViewController : TableViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) id<RegionFilterDelegate> filterDelegate;

@end

@protocol RegionFilterDelegate <NSObject>

@required

- (void)filterChange:(Region *)region;

@end

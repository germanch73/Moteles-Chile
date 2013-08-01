//
//  SettingsViewController.h
//  Moteles Chile
//
//  Created by Germán on 28-07-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "TableViewController.h"
#import "RegionFilterViewController.h"

@interface SettingsViewController : TableViewController<UITableViewDataSource, UITableViewDelegate, RegionFilterDelegate>

@end

//
//  HotelViewController.h
//  Moteles Chile
//
//  Created by German Chavez on 01-07-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "TableViewController.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface HotelViewController : TableViewController<UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) Hotel *hotel;
@property (strong, nonatomic) IBOutlet UIButton *iconButton;
@property (strong, nonatomic) IBOutlet UIButton *promotionsButton;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;
@property (strong, nonatomic) IBOutlet UIButton *callButton;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
@property (strong, nonatomic) IBOutlet UIButton *nearButton;
@property (strong, nonatomic) IBOutlet UIButton *webButton;
@property (strong, nonatomic) IBOutlet UIButton *mailButton;
@property (strong, nonatomic) IBOutlet UIButton *wazeButton;

- (IBAction)comment;
- (IBAction)call;
- (IBAction)map;
- (IBAction)near;
- (IBAction)web;
- (IBAction)mail;
- (IBAction)waze;

@end

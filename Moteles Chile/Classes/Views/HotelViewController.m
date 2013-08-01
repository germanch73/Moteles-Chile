//
//  HotelViewController.m
//  Moteles Chile
//
//  Created by German Chavez on 01-07-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "HotelViewController.h"
#import "GAI.h"
#import "NearViewController.h"
#import "MapViewController.h"
#import "WebViewController.h"

@interface HotelViewController () {
    UISegmentedControl *_viewSegmentedControl;
}

-(IBAction)viewSegmentChanged:(id)sender;

@end

@implementation HotelViewController

@synthesize hotel = _hotel;
@synthesize iconButton = _iconButton;
@synthesize promotionsButton = _promotionsButton;
@synthesize callButton = _callButton;
@synthesize mapButton = _mapButton;
@synthesize nearButton = _nearButton;
@synthesize webButton = _webButton;
@synthesize mailButton = _mailButton;
@synthesize wazeButton = _wazeButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"Hotel";
    
    self.title = _hotel.name;
    
    UIImage *image = (_hotel.largeIcon) ? _hotel.largeIcon : [UI instance].emptyLargeIconImage;
    
    [_iconButton setBackgroundImage:image forState:UIControlStateNormal];
    [_iconButton setBackgroundImage:image forState:UIControlStateHighlighted];
    [_iconButton setBackgroundImage:image forState:UIControlStateDisabled];
    [_iconButton setBackgroundImage:image forState:UIControlStateSelected];
    
    [_promotionsButton setBackgroundImage:[[UIImage imageNamed:@"button-normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)] forState:UIControlStateNormal];
    [_promotionsButton setBackgroundImage:[[UIImage imageNamed:@"button-highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)] forState:UIControlStateHighlighted];
    [_promotionsButton setBackgroundImage:[[UIImage imageNamed:@"button-disabled"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)] forState:UIControlStateDisabled];
    //[_promotionsButton setBackgroundImage:[[UIImage imageNamed:@"button"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)] forState:UIControlStateSelected];
    
    //id tracker = [GAI sharedInstance].defaultTracker;
    //[tracker sendEventWithCategory:@"Hotel" withAction:@"HotelView" withLabel:_hotel.name withValue:nil];
    
    if (self.tableView.tableHeaderView != nil) {
        self.tableView.tableHeaderView.backgroundColor = HEADER_COLOR;
    }
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
    UITableViewCell *cell = nil;
    
    /*if (indexPath.section == SectionNear) {
        static NSString *CellIdentifier = @"NearCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    } else if (indexPath.section == SectionComments) {
        static NSString *CellIdentifier = @"CommentsCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
        }
    } else {
        static NSString *CellIdentifier = @"DetailCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
        }
    }
    
    BOOL first = NO;
    BOOL last = NO;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.section) {
        case SectionLocation:
            switch (indexPath.row) {
                case LocationRowAddress:
                    cell.textLabel.text = @"Dirección";
                    cell.detailTextLabel.text = self.hotel.address;
                    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    first = YES;
                    break;
                    
                case LocationRowLocality:
                    cell.textLabel.text = @"Comuna";
                    cell.detailTextLabel.text = self.hotel.locality;
                    break;
                    
                case LocationRowDistance:
                    cell.textLabel.text = @"Distancia";
                    //cell.detailTextLabel.text = self.hotel.distanceDescription;
                    last = YES;
                    break;
            }
            break;
            
        case SectionPrice:
            switch (indexPath.row) {
                case PriceRowCategory:
                    cell.textLabel.text = @"Categoría";
                    //cell.detailTextLabel.text = self.hotel.priceCategory;
                    first = YES;
                    break;
                    
                case PriceRowPrice:
                    cell.textLabel.text = @"Precio";
                    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ [%@-%@]", [NSString stringWithPrice:self.hotel.price], [NSString stringWithPrice:self.hotel.minorPrice], [NSString stringWithPrice:self.hotel.majorPrice]];
                    last = YES;
                    break;
                    
            }
            break;
            
        case SectionContact:
            switch (indexPath.row) {
                case ContactRowPhone:
                    cell.textLabel.text = @"Teléfono";
                    //cell.detailTextLabel.text = [NSString stringWithPhone:self.hotel.phone];
                    if (self.hotel.phone && ![self.hotel.phone isEqual:@""]) {
                        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                    first = YES;
                    break;
                    
                case ContactRowWeb:
                    cell.textLabel.text = @"Sitio web";
                    cell.detailTextLabel.text = self.hotel.web;
                    if (self.hotel.web && ![self.hotel.web isEqual:@""]) {
                        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                    break;
                    
                case ContactRowMail:
                    cell.textLabel.text = @"Correo";
                    cell.detailTextLabel.text = self.hotel.mail;
                    if (self.hotel.mail && ![self.hotel.mail isEqual:@""]) {
                        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                    last = YES;
                    break;
            }
            break;
            
        case SectionNear:
            cell.textLabel.text = @"Cercanos a éste";
            //cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            first = YES;
            last = YES;
            break;
            
        case SectionComments:
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            first = YES;
            last = YES;
            break;
    }*/
    
    /*if (cell.selectionStyle != UITableViewCellSelectionStyleNone) {
        SelectedBackgroundView *selectedBackgroundView = [[SelectedBackgroundView alloc] initWithFrame:cell.frame isFirst:first isLast:last];
        cell.selectedBackgroundView = selectedBackgroundView;
    }*/
    
    //cell.backgroundColor = CELL_COLOR;
    //cell.textLabel.backgroundColor = [UIColor clearColor];
    //cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    /*if (indexPath.section == SectionNear) {
        cell.textLabel.textColor = TEXT_COLOR;
    } else if (indexPath.section == SectionComments) {
        //ValorationsCell *valorationsCell = (ValorationsCell *)cell;
        //valorationsCell.hotel = self.hotel;
    } else {
        cell.textLabel.textColor = DETAIL_TEXT_COLOR;
        cell.detailTextLabel.textColor = TEXT_COLOR;
    }*/
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEADER_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    float width = self.view.bounds.size.width;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, HEADER_HEIGHT)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithHeight:HEADER_HEIGHT color:HEADER_COLOR bottomColor:SEPARATOR_COLOR]];
    
    NSArray *segmentTextContent = [NSArray arrayWithObjects: @"Detalles", @"Comentarios", @"Tarifas", nil];
    _viewSegmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
    _viewSegmentedControl.frame = CGRectMake(15, (HEADER_HEIGHT - 30) / 2, width - 30, 30);
    
    [_viewSegmentedControl addTarget:self action:@selector(viewSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    _viewSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    _viewSegmentedControl.enabled = true;
    _viewSegmentedControl.selectedSegmentIndex = 0;
    
    [view addSubview:_viewSegmentedControl];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case SectionLocation:
            switch (indexPath.row) {
                case LocationRowAddress:
                    [self map];
                    break;
                    
                case LocationRowLocality:
                    break;
                    
                case LocationRowDistance:
                    break;
            }
            break;
            
        case SectionPrice:
            switch (indexPath.row) {
                case PriceRowCategory:
                    break;
                    
                case PriceRowPrice:
                    break;
                    
            }
            break;
            
        case SectionContact:
            switch (indexPath.row) {
                case ContactRowPhone:
                    [self call];
                    break;
                    
                case ContactRowWeb:
                    [self web];
                    break;
                    
                case ContactRowMail:
                    [self mail];
                    break;
            }
            break;
            
        case SectionNear:
            [self near];
            break;
            
        case SectionComments:
            [self comments];
            break;
    }*/
}

#pragma mark - View acions

- (IBAction)comment
{
    /*CommentsViewController *viewController = [[CommentsViewController alloc] initWithNibName:@"CommentsView" bundle:nil];
     
     viewController.hotel = self.hotel;
     viewController.level = self.level + 1;
     
     [self.navigationController pushViewController:viewController animated:YES];*/
}

- (IBAction)call
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:+%@", self.hotel.phone]];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)map
{
    MapViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Map"];
    
    //viewController.hotel = self.hotel;
     
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)near
{
    NearViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Near"];
    
    viewController.fixedLocation = [[CLLocation alloc] initWithLatitude:self.hotel.latitude longitude:self.hotel.longitude];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)web
{
    WebViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Web"];

    //viewController.hotel = self.hotel;
     
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)mail
{
    MFMailComposeViewController* viewController = [[MFMailComposeViewController alloc] init];
    
    viewController.mailComposeDelegate = self;
    [viewController setToRecipients:[NSArray arrayWithObjects:self.hotel.mail, nil]];
    viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)waze
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"waze://"]]) {
        NSString *urlStr = [NSString stringWithFormat:@"waze://?ll=%f,%f&navigate=yes", _hotel.latitude, _hotel.longitude];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/id323229106"]];
    }
}

#pragma mark - Mail Compose delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - view actions

-(IBAction)viewSegmentChanged:(id)sender
{

}

@end

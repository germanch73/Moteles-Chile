//
//  LoadingViewController.m
//  Moteles Chile
//
//  Created by German Chavez on 28-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "LoadingViewController.h"
#import "JSON.h"

@interface LoadingViewController () {
    NSMutableData *_hotelsData;
    NSURLConnection *_hotelsConnection;
    NSMutableData *_servicesData;
    NSURLConnection *_servicesConnection;
    NSMutableData *_pricesData;
    NSURLConnection *_pricesConnection;
    NSMutableData *_promotionsData;
    NSURLConnection *_promotionsConnection;
    NSMutableData *_commentsData;
    NSURLConnection *_commentsConnection;
    NSMutableData *_featuredData;
    NSURLConnection *_featuredConnection;
    CLLocationManager *_locationManager;
}

- (void)loadHotels;
- (void)loadServices;
- (void)loadPrices;
- (void)loadPromotions;
- (void)loadComments;
- (void)loadFeatured;
- (void)createLocalities;

@end

@implementation LoadingViewController

@synthesize loadDelegate = _loadDelegate;
@synthesize imageView = _imageView;
@synthesize stateLabel = _stateLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackedViewName = @"Loading";
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat height = CGRectGetHeight(screen);
    
    if (height == 568) {
        _imageView.image = [UIImage imageNamed:@"Default-568h@2x"];
    }
    
    [self loadHotels];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Load implementation

- (void)loadHotels
{
    self.stateLabel.text = @"Cargando moteles...";
    
    _hotelsData = [NSMutableData data];
    
    NSString *urlString = @"http://www.naranjasoftware.cl/Motels2.svc/GetMotels";
    
    _hotelsConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] delegate:self];
}

- (void)loadServices
{
    self.stateLabel.text = @"Cargando servicios...";
    
    _servicesData = [NSMutableData data];
    
    NSString *urlString = @"http://www.naranjasoftware.cl/Motels2.svc/GetServices";
    
    _servicesConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] delegate:self];
}

- (void)loadPrices
{
    self.stateLabel.text = @"Cargando precios...";
    
    _pricesData = [NSMutableData data];
    
    NSString *urlString = @"http://www.naranjasoftware.cl/Motels2.svc/GetPrices";
    
    _pricesConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] delegate:self];
}

- (void)loadPromotions
{
    self.stateLabel.text = @"Cargando promociones...";
    
    _promotionsData = [NSMutableData data];
    
    NSString *urlString = @"http://www.naranjasoftware.cl/Motels2.svc/GetPromotions";
    
    _promotionsConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] delegate:self];
}

- (void)loadComments
{
    self.stateLabel.text = @"Cargando comentarios...";
    
    _commentsData = [NSMutableData data];
    
    NSString *urlString = @"http://www.naranjasoftware.cl/Motels2.svc/GetComments";
    
    _commentsConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] delegate:self];
}

- (void)loadFeatured
{
    self.stateLabel.text = @"Cargando destacados...";
    
    _featuredData = [NSMutableData data];
    
    NSString *urlString = @"http://www.naranjasoftware.cl/Motels2.svc/GetFeatured";
    
    _featuredConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] delegate:self];
}

- (void)createLocalities
{
    self.stateLabel.text = @"Cargando regiones y comunas...";
    
    Data *data = [Data instance];
    
    data.regions = [[NSMutableArray alloc] init];
    
    int regionIndex = 0;
    for (Hotel *hotel in data.hotels) {
        Region *region = nil;
        Locality *locality = nil;
        Locality *allLocalities = nil;
        
        for (Region *tempRegion in data.regions) {
            if ([tempRegion.name compare:hotel.region] == NSOrderedSame) {
                region = tempRegion;
                allLocalities = [region.localities objectAtIndex:0];
                break;
            }
        }
        
        if (!region) {
            region = [[Region alloc] init];
            region.type = 1;
            region.code = 1 << regionIndex;
            region.name = hotel.region;
            region.hotels = [[NSMutableArray alloc] init];
            region.localities = [[NSMutableArray alloc] init];
            [data.regions addObject:region];
            
            regionIndex++;
            
            allLocalities = [[Locality alloc] init];
            allLocalities.type = 0;
            allLocalities.name = @"Todas las comunas";
            allLocalities.region = region.name;
            allLocalities.hotels = [[NSMutableArray alloc] init];
            [region.localities addObject:allLocalities];
        }
        
        hotel.regionCode = region.code;
        
        for (Locality *tempLocality in region.localities) {
            if ([tempLocality.name compare:hotel.locality] == NSOrderedSame) {
                locality = tempLocality;
                break;
            }
        }
        
        if (!locality) {
            locality = [[Locality alloc] init];
            locality.type = 1;
            locality.name = hotel.locality;
            locality.region = region.name;
            locality.hotels = [[NSMutableArray alloc] init];
            [region.localities addObject:locality];
        }
        
        [locality.hotels addObject:hotel];
        [allLocalities.hotels addObject:hotel];
        [region.hotels addObject:hotel];
    }
    
    [data.regions sortUsingComparator:(NSComparator)^(id obj1, id obj2) {
        const Region *region1 = (const Region *)obj1;
        const Region *region2 = (const Region *)obj2;
        
        NSComparisonResult result = NSOrderedSame;
        
        if (region1.type < region2.type) {
            result = NSOrderedAscending;
        } else if (region1.type > region2.type) {
            result = NSOrderedDescending;
        }
        if (result == NSOrderedSame) {
            result = [region1.name caseInsensitiveCompare:region2.name];
        }
        
        return result;
    }];
    
    for (Region *region in data.regions) {
        if (region.localities.count == 2) {
            [region.localities removeObjectAtIndex:0];
        } else {
            [region.localities sortUsingComparator:(NSComparator)^(id obj1, id obj2) {
                const Locality *locality1 = (const Locality *)obj1;
                const Locality *locality2 = (const Locality *)obj2;
                
                NSComparisonResult result = NSOrderedSame;
                
                if (locality1.type < locality2.type) {
                    result = NSOrderedAscending;
                } else if (locality1.type > locality2.type) {
                    result = NSOrderedDescending;
                }
                if (result == NSOrderedSame) {
                    result = [locality1.name caseInsensitiveCompare:locality2.name];
                }
                
                return result;
            }];
        }
    }
    
    if (data.regions.count) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        id obj = [prefs objectForKey:@"activeRegion"];
        if (obj) {
            int regionCode = [prefs integerForKey:@"activeRegion"];
            for (Region *region in data.regions) {
                if (region.code != regionCode) continue;
                data.activeRegion = region;
                break;
            }
        }
    }
}

#pragma mark -
#pragma mark Download support (NSURLConnectionDelegate)

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == _hotelsConnection) {
        [_hotelsData appendData:data];
    } else if (connection == _servicesConnection) {
        [_servicesData appendData:data];
    } else if (connection == _pricesConnection) {
        [_pricesData appendData:data];
    } else if (connection == _promotionsConnection) {
        [_promotionsData appendData:data];
    } else if (connection == _commentsConnection) {
        [_commentsData appendData:data];
    } else if (connection == _featuredConnection) {
        [_featuredData appendData:data];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (connection == _hotelsConnection) {
        _hotelsData = nil;
        
        _hotelsConnection = nil;
    } else if (connection == _servicesConnection) {
        _servicesData = nil;
        
        _servicesConnection = nil;
    } else if (connection == _pricesConnection) {
        _pricesData = nil;
        
        _pricesConnection = nil;
    } else if (connection == _promotionsConnection) {
        _promotionsData = nil;
        
        _promotionsConnection = nil;
    } else if (connection == _commentsConnection) {
        _commentsData = nil;
        
        _commentsConnection = nil;
    } else if (connection == _featuredConnection) {
        _featuredData = nil;
        
        _featuredConnection = nil;
    }
    
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
    [alertView show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    Data *data = [Data instance];
    
    if (connection == _hotelsConnection) {
        NSString *jsonString = [[NSString alloc] initWithData:_hotelsData encoding:NSUTF8StringEncoding];
        
        _hotelsData = nil;
        _hotelsConnection = nil;
        
        NSDictionary *dict = [jsonString JSONValue];
        NSArray *array = [dict objectForKey:@"Motels"];
        data.hotels = [[NSMutableArray alloc] initWithCapacity:array.count];
        
        for (NSDictionary *item in array) {
            Hotel *hotel = [[Hotel alloc] init];
            hotel.code = [[item objectForKey:@"Code"] intValue];
            hotel.name = [item objectForKey:@"Name"];
            hotel.region = [item objectForKey:@"Region"];
            hotel.locality = [item objectForKey:@"Locality"];
            hotel.address = [item objectForKey:@"Address"];
            hotel.phone = [item objectForKey:@"Phone"];
            hotel.web = [item objectForKey:@"Web"];
            hotel.mail = [item objectForKey:@"Email"];
            hotel.price = [[item objectForKey:@"Price"] floatValue];
            hotel.price3 = [[item objectForKey:@"Price3"] floatValue];
            hotel.price12 = [[item objectForKey:@"Price12"] floatValue];
            hotel.minorPrice = [[item objectForKey:@"Minimum"] floatValue];
            hotel.majorPrice = [[item objectForKey:@"Maximum"] floatValue];
            hotel.services = [[item objectForKey:@"Services"] intValue];
            hotel.valorations = [[item objectForKey:@"Comments"] intValue];
            hotel.rating = [[item objectForKey:@"Rating"] floatValue];
            hotel.latitude = [[item objectForKey:@"Latitude"] floatValue];
            hotel.longitude = [[item objectForKey:@"Longitude"] floatValue];
            int images = [[item objectForKey:@"Images"] intValue];
            if (images) {
                hotel.images = [[NSMutableArray alloc] initWithCapacity:images];
                UIImage *image = [[UI instance] emptyPictureImage];
                for (int i = 0; i < images; i++) {
                    [hotel.images addObject:image];
                }
            }
            [data.hotels addObject:hotel];
        }
        
        [self loadServices];
    } else if (connection == _servicesConnection) {
        NSString *jsonString = [[NSString alloc] initWithData:_servicesData encoding:NSUTF8StringEncoding];
        
        _servicesData = nil;
        _servicesConnection = nil;
        
        NSDictionary *dict = [jsonString JSONValue];
        NSArray *array = [dict objectForKey:@"Services"];
        data.services = [[NSMutableArray alloc] init];
        
        for (NSDictionary *item in array) {
            Service *service = [[Service alloc] init];
            service.code = [[item objectForKey:@"Code"] intValue];
            service.name = [item objectForKey:@"Name"];
            NSString *iconName = [item objectForKey:@"Icon"];
            if (iconName != nil) {
                NSURL *iconUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.naranjasoftware.cl/App/Moteles2/services/%@", iconName]];
                NSData *iconData = [NSData dataWithContentsOfURL:iconUrl];
                service.icon = [UIImage imageWithData:iconData];
                //service.icon = [UIImage imageNamed:iconName];
            }
            iconName = nil;//[item objectForKey:@"Icon2"];
            if (iconName != nil) {
                NSURL *iconUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.naranjasoftware.cl/App/Moteles2/services/%@", iconName]];
                NSData *iconData = [NSData dataWithContentsOfURL:iconUrl];
                service.smallIcon = [UIImage imageWithData:iconData];
            } else {
                service.smallIcon = service.icon;
            }
            
            for (Hotel *hotel in data.hotels) {
                if (service.code & hotel.services) {
                    service.count++;
                }
            }
            
            [data.services addObject:service];
        }
        
        [data.services sortUsingComparator:(NSComparator)^(id obj1, id obj2) {
            const Service *service1 = (const Service *)obj1;
            const Service *service2 = (const Service *)obj2;
            NSComparisonResult result = [service1.name caseInsensitiveCompare:service2.name];
            return result;
        }];
        
        [self loadPrices];
    } else if (connection == _pricesConnection) {
        NSString *jsonString = [[NSString alloc] initWithData:_pricesData encoding:NSUTF8StringEncoding];
        
        _pricesData = nil;
        _pricesConnection = nil;
        
        NSDictionary *dict = [jsonString JSONValue];
        NSArray *array = [dict objectForKey:@"Prices"];
        data.prices = [[NSMutableArray alloc] init];
        
        for (NSDictionary *item in array) {
            Price *price = [[Price alloc] init];
            price.name = [item objectForKey:@"Name"];
            price.lower = [[item objectForKey:@"Lower"] floatValue];
            price.upper = [[item objectForKey:@"Upper"] floatValue];
            price.hotels = [[NSMutableArray alloc] init];
            
            for (Hotel *hotel in data.hotels) {
                if (hotel.price < price.lower) continue;
                if (hotel.price > price.upper) continue;
                [price.hotels addObject:hotel];
            }
            
            [data.prices addObject:price];
        }
        
        [data.prices sortUsingComparator:(NSComparator)^(id obj1, id obj2) {
            const Price *price1 = (const Price *)obj1;
            const Price *price2 = (const Price *)obj2;
            if (price1.lower < price2.lower) {
                return NSOrderedAscending;
            }
            if (price1.lower > price2.lower) {
                return NSOrderedDescending;
            }
            return NSOrderedSame;
        }];
        
        [self loadPromotions];
    } else if (connection == _promotionsConnection) {
        /*NSString *jsonString = [[NSString alloc] initWithData:_featuredData encoding:NSUTF8StringEncoding];
        
        _promotionsData = nil;
        
        _promotionsConnection = nil;
        
        NSDictionary *dict = [jsonString JSONValue];
        
        NSArray *array = [dict objectForKey:@"Promotions"];
        
        data.promotions = [[NSMutableArray alloc] init];*/
        
        [self loadComments];
    } else if (connection == _commentsConnection) {
        NSString *jsonString = [[NSString alloc] initWithData:_commentsData encoding:NSUTF8StringEncoding];
        
        _commentsData = nil;
        _commentsConnection = nil;
        
        NSDictionary *dict = [jsonString JSONValue];
        NSArray *array = [dict objectForKey:@"Comments"];
        data.comments = [[NSMutableArray alloc] init];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        
        for (NSDictionary *item in array) {
            int code = [[item objectForKey:@"Hotel"] intValue];
            Comment *comment = [[Comment alloc] init];
            comment.index = [[item objectForKey:@"Index"] intValue];
            comment.nick = [item objectForKey:@"Nick"];
            comment.title = [item objectForKey:@"Title"];
            comment.description = [item objectForKey:@"Description"];
            comment.added = [item objectForKey:@"Added"];
            comment.rating = [[item objectForKey:@"Rating"] doubleValue];
            comment.date = [dateFormatter dateFromString:comment.added];
            for (Hotel *hotel in data.hotels) {
                if (hotel.code != code) continue;
                comment.hotel = hotel;
                break;
            }
            
            [data.comments addObject:comment];
        }
        
        [self loadFeatured];
    } else if (connection == _featuredConnection) {
        NSString *jsonString = [[NSString alloc] initWithData:_featuredData encoding:NSUTF8StringEncoding];
        
        _featuredData = nil;
        
        _featuredConnection = nil;
        
        NSDictionary *dict = [jsonString JSONValue];
        
        NSArray *array = [dict objectForKey:@"Featured"];
        
        data.featuredHotels = [[NSMutableArray alloc] init];
        
        for (NSNumber *item in array) {
            int code = [item intValue];
            for (Hotel *hotel in data.hotels) {
                if (hotel.code == code) {
                    [data.featuredHotels addObject:hotel];
                    break;
                }
            }
        }
        
        [self createLocalities];
        
        if ([Data instance].activeRegion) {
            if (self.loadDelegate) {
                [self.loadDelegate dataDidFinishLoading];
            }
        } else {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            _locationManager.distanceFilter = 100.0;
            [_locationManager startUpdatingLocation];
        }
    }
}

#pragma mark - Location Manager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (newLocation) {
        [_locationManager stopUpdatingLocation];
        
        Data *data = [Data instance];
        
        for (Region *region in data.regions) {
            region.latitude = 0;
            region.longitude = 0;
            int count = 0;
            for (Hotel *hotel in region.hotels) {
                if (!hotel.latitude) continue;
                if (!hotel.longitude) continue;
                region.latitude += hotel.latitude;
                region.longitude += hotel.longitude;
                count++;
            }
            if (count) {
                region.latitude = region.latitude / (double)count;
                region.longitude = region.longitude / (double)count;
            }
        }
        
        Region *activeRegion = nil;
        
        double minDistance = -1;
        for (Region *region in data.regions) {
            CLLocation *point = [[CLLocation alloc] initWithLatitude:region.latitude longitude:region.longitude];
            double distance = [point distanceFromLocation:newLocation];
            if ((minDistance < 0) || (distance < minDistance)) {
                minDistance = distance;
                activeRegion = region;
            }
        }
        
        [Data instance].activeRegion = activeRegion;
        
        if (self.loadDelegate) {
            [self.loadDelegate dataDidFinishLoading];
        }
    }
}

@end

//
//  Data.m
//  iMoteles
//
//  Created by Germán Chávez on 05-11-12.
//  Copyright (c) 2012 Germán Chávez. All rights reserved.
//

#import "Data.h"

@interface DownloadData : NSObject

@property (nonatomic, getter = isLoading) BOOL loading;
@property (nonatomic, getter = isLoaded) BOOL loaded;
@property (strong, nonatomic) NSMutableData *imageData;
@property (strong, nonatomic) NSURLConnection *imageConnection;

@end

@implementation DownloadData

@synthesize loading = _loading;
@synthesize loaded = _loaded;
@synthesize imageData = _imageData;
@synthesize imageConnection = _imageConnection;

@end

@interface Hotel ()

@property (strong, nonatomic) NSMutableData *iconData;
@property (strong, nonatomic) NSURLConnection *iconConnection;

@property (strong, nonatomic) NSMutableData *imageData;
@property (strong, nonatomic) NSURLConnection *imageConnection;

@property (strong, nonatomic) NSMutableArray *downloads;

@end

@implementation Hotel

@synthesize code = _code;
@synthesize name = _name;
@synthesize region = _region;
@synthesize locality = _locality;
@synthesize address = _address;
@synthesize phone = _phone;
@synthesize web = _web;
@synthesize mail = _mail;
@synthesize smallIcon = _smallIcon;
@synthesize largeIcon = _largeIcon;
@synthesize image = _image;
@synthesize images = _images;
@synthesize price = _price;
@synthesize price3 = _price3;
@synthesize price12 = _price12;
@synthesize minorPrice = _minorPrice;
@synthesize majorPrice = _majorPrice;
@synthesize services = _services;
@synthesize valorations = _valorations;
@synthesize rating = _rating;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize distance = _distance;
@synthesize regionCode = _regionCode;

@synthesize iconLoading = _iconLoading;
@synthesize iconLoaded = _iconLoaded;
@synthesize loadIconDelegates = _loadIconDelegates;
@synthesize iconData = _iconData;
@synthesize iconConnection = _iconConnection;

@synthesize imagesLoading = _imagesLoading;
@synthesize imagesLoaded = _imagesLoaded;
@synthesize loadImagesDelegates = _loadImagesDelegates;
@synthesize downloads = _downloads;

- (id)init
{
    if (self = [super init]) {
        self.loadIconDelegates = [[NSMutableArray alloc] init];
        self.loadImageDelegates = [[NSMutableArray alloc] init];
        self.loadImagesDelegates = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)downloadIcon
{
    if (!self.isIconLoading && !self.isIconLoaded) {
        self.iconLoading = YES;
        self.iconLoaded = NO;
        
        self.iconData = [NSMutableData data];
        NSString *imageUrl = [NSString stringWithFormat:@"http://www.naranjasoftware.cl/App/Moteles2/icons/%d.png", self.code];
        self.iconConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] delegate:self];
    }
}

- (void)downloadImage
{
    if (!self.isImageLoading && !self.isImageLoaded) {
        self.imageLoading = YES;
        self.imageLoaded = NO;
        
        self.imageData = [NSMutableData data];
        NSString *imageUrl = [NSString stringWithFormat:@"http://www.naranjasoftware.cl/App/Moteles/images/%d-1.jpg", self.code];
        self.imageConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] delegate:self];
    }
}

- (void)downloadImages
{
    if (!self.isImagesLoading && !self.isImagesLoaded) {
        self.imagesLoading = YES;
        self.imagesLoaded = NO;
        
        self.downloads = [[NSMutableArray alloc] initWithCapacity:self.images.count];
        
        for (int i = 0; i < self.images.count; i++) {
            DownloadData *download = [[DownloadData alloc] init];
            [self.downloads addObject:download];
            download.loading = YES;
            download.loaded = NO;
            download.imageData = [NSMutableData data];
            NSString *imageUrl = [NSString stringWithFormat:@"http://www.naranjasoftware.cl/App/Moteles/images/%d-%d.jpg", self.code, i + 1];
            download.imageConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] delegate:self];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == self.iconConnection) {
        [self.iconData appendData:data];
    } else if (connection == self.imageConnection) {
        [self.imageData appendData:data];
    } else {
        for (int i = 0; i < self.images.count; i++) {
            DownloadData *download = [self.downloads objectAtIndex:i];
            if (connection == download.imageConnection) {
                [download.imageData appendData:data];
                break;
            }
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (connection == self.iconConnection) {
        self.iconLoading = NO;
        self.iconLoaded = YES;
        
        self.iconData = nil;
        self.iconConnection = nil;
        
        if (self.loadIconDelegates) {
            for (id<LoadIconDelegate> delegate in self.loadIconDelegates) {
                [delegate iconDidFail];
            }
        }
    } else if (connection == self.imageConnection) {
        self.imageLoading = NO;
        self.imageLoaded = YES;
        
        self.imageData = nil;
        self.imageConnection = nil;
        
        if (self.loadImageDelegates) {
            for (id<LoadImageDelegate> delegate in self.loadImageDelegates) {
                [delegate imageDidFail];
            }
        }
    } else {
        for (int i = 0; i < self.images.count; i++) {
            DownloadData *download = [self.downloads objectAtIndex:i];
            if (connection == download.imageConnection) {
                download.loading = NO;
                download.loaded = NO;
                
                download.imageData = nil;
                download.imageConnection = nil;
                
                self.imagesLoading = NO;
                self.imagesLoaded = YES;
                for (int x = 0; x < self.images.count; x++) {
                    download = [self.downloads objectAtIndex:x];
                    self.imagesLoading = self.isImagesLoading || download.isLoading;
                    self.imagesLoaded = self.isImagesLoaded || download.isLoaded;
                }
                
                if (!self.imagesLoading) {
                    self.downloads = nil;
                }
                
                if (self.loadImagesDelegates) {
                    for (id<LoadImagesDelegate> delegate in self.loadImagesDelegates) {
                        [delegate imageDidFail:i];
                    }
                }
                break;
            }
        }
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == self.iconConnection) {
        self.iconLoading = NO;
        self.iconLoaded = YES;
        
        self.smallIcon = [[UIImage alloc] initWithData:self.iconData];
        self.largeIcon = [[UIImage alloc] initWithData:self.iconData];
        
        self.iconData = nil;
        self.iconConnection = nil;
        
        if (!self.smallIcon) {
            self.smallIcon = [[UI instance] emptySmallIconImage];
        } else {
            self.smallIcon = [UIImage ellipticImageWithImage:self.smallIcon];
        }
        
        if (!self.largeIcon) {
            self.largeIcon = [[UI instance] emptyLargeIconImage];
        } else {
            self.largeIcon = [UIImage roundedImageWithImage:self.largeIcon cornerRadius:10];
        }
        
        if (self.loadIconDelegates) {
            if (self.loadIconDelegates) {
                for (id<LoadIconDelegate> delegate in self.loadIconDelegates) {
                    [delegate iconDidFinishLoading];
                }
            }
        }
    } else if (connection == self.imageConnection) {
        self.imageLoading = NO;
        self.imageLoaded = YES;
        
        self.image = [[UIImage alloc] initWithData:self.imageData];
        
        self.imageData = nil;
        self.imageConnection = nil;
        
        if (!self.image) {
            self.image = [[UI instance] unknownImage];
        } else {
            self.image = [UIImage roundedImageWithImage:self.image cornerRadius:10];
        }
        
        if (self.loadImageDelegates) {
            if (self.loadImageDelegates) {
                for (id<LoadImageDelegate> delegate in self.loadImageDelegates) {
                    [delegate imageDidFinishLoading];
                }
            }
        }
    } else {
        for (int i = 0; i < self.images.count; i++) {
            DownloadData *download = [self.downloads objectAtIndex:i];
            if (connection == download.imageConnection) {
                download.loading = NO;
                download.loaded = YES;
                
                UIImage *iimage = [[UIImage alloc] initWithData:download.imageData];
                if (!iimage) {
                    iimage = [[UI instance] emptyPictureImage];
                }
                [self.images setObject:iimage atIndexedSubscript:i];
                
                download.imageData = nil;
                download.imageConnection = nil;
                
                self.imagesLoading = NO;
                self.imagesLoaded = YES;
                for (int x = 0; x < self.images.count; x++) {
                    download = [self.downloads objectAtIndex:x];
                    self.imagesLoading = self.isImagesLoading || download.isLoading;
                    self.imagesLoaded = self.isImagesLoaded || download.isLoaded;
                }
                
                if (!self.imagesLoading) {
                    self.downloads = nil;
                }
                
                if (self.loadImagesDelegates) {
                    for (id<LoadImagesDelegate> delegate in self.loadImagesDelegates) {
                        [delegate imageDidFinishLoading:i];
                    }
                }
                break;
            }
        }
    }
}

@end

@implementation Region

@synthesize type = _type;
@synthesize code = _code;
@synthesize name = _name;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize hotels = _hotels;
@synthesize localities = _localities;

@end

@implementation Locality

@synthesize type = _type;
@synthesize name = _name;
@synthesize region = _region;
@synthesize hotels = _hotels;

@end

@implementation Service

@synthesize name = _name;
@synthesize code = _code;
@synthesize icon = _icon;
@synthesize smallIcon = _smallIcon;
@synthesize count = _count;

@end

@implementation Price

@synthesize name = _name;
@synthesize lower = _lower;
@synthesize upper = _upper;
@synthesize hotels = _hotels;

@end

@implementation Comment

@synthesize hotel = _hotel;
@synthesize index = _index;
@synthesize nick = _nick;
@synthesize title = _title;
@synthesize description = _description;
@synthesize added = _added;
@synthesize rating = _rating;
@synthesize date = _date;

@end

@implementation Data

@synthesize hotels = _hotels;
@synthesize services = _services;
@synthesize promotions = _promotions;
@synthesize comments = _comments;
@synthesize regions = _regions;
@synthesize prices = _prices;
@synthesize featuredHotels = _featuredHotels;

@synthesize activeRegion = _activeRegion;
@synthesize activeHotels = _activeHotels;
@synthesize activeLocalities = _activeLocalities;
@synthesize activeServices = _activeServices;
@synthesize activePrices = _activePrices;
@synthesize activePromotions = _activePromotions;
@synthesize activeComments = _activeComments;

+ (Data *)instance
{
    static Data *data = nil;
    
    if (!data) {
        data = [[Data alloc] init];
    }
    
    return data;
}

-(void)setActiveRegion:(Region *)activeRegion
{
    if (_activeRegion != activeRegion) {
        _activeRegion = activeRegion;
        
        _activeHotels = [[NSMutableArray alloc] init];
        
        for (Hotel *hotel in _hotels) {
            if (hotel.regionCode != _activeRegion.code) continue;
            [_activeHotels addObject:hotel];
        }
        
        _activeServices = [[NSMutableArray alloc] init];
        
        for (Service *service in _services) {
            int count = 0;
            for (Hotel *hotel in _activeHotels) {
                if ((service.code & hotel.services) == 0) continue;
                count++;
            }
            if (count) {
                Service *copy = [[Service alloc] init];
                copy.name = service.name;
                copy.code = service.code;
                copy.icon = service.icon;
                copy.smallIcon = service.smallIcon;
                copy.count = count;
                [_activeServices addObject:copy];
            }
        }
        
        _activePrices = [[NSMutableArray alloc] init];
        
        for (Price *price in _prices) {
            BOOL found = NO;
            for (Hotel *hotel in _activeHotels) {
                if (hotel.price < price.lower) continue;
                if (hotel.price > price.upper) continue;
                found = YES;
                break;
            }
            if (found) {
                Price *copy = [[Price alloc] init];
                copy.name = price.name;
                copy.lower = price.lower;
                copy.upper = price.upper;
                copy.hotels = [[NSMutableArray alloc] init];
                for (Hotel *hotel in _activeHotels) {
                    if (hotel.price < price.lower) continue;
                    if (hotel.price > price.upper) continue;
                    [copy.hotels addObject:hotel];
                }
                [_activePrices addObject:copy];
            }
        }
        
        _activeLocalities = [[NSMutableArray alloc] init];
        
        for (Region *region in _regions) {
            if (region.code != _activeRegion.code) continue;
            for (Locality *locality in region.localities) {
                [_activeLocalities addObject:locality];
            }
            break;
        }
        
        _activePromotions = [[NSMutableArray alloc] init];
        
        _activeComments = [[NSMutableArray alloc] init];
        
        for (Comment *comment in _comments) {
            BOOL found = NO;
            for (Hotel *hotel in _activeHotels) {
                if (hotel.code != comment.hotel.code) continue;
                found = YES;
                break;
            }
            if (found) {
                [_activeComments addObject:comment];
            }
        }
    }
}


@end

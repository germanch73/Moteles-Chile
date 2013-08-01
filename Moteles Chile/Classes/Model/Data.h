//
//  Data.h
//  iMoteles
//
//  Created by Germán Chávez on 05-11-12.
//  Copyright (c) 2012 Germán Chávez. All rights reserved.
//

#import <MapKit/MapKit.h>

@protocol LoadIconDelegate <NSObject>

@required

- (void)iconDidFail;
- (void)iconDidFinishLoading;

@end

@protocol LoadImageDelegate <NSObject>

@required

- (void)imageDidFail;
- (void)imageDidFinishLoading;

@end

@protocol LoadImagesDelegate <NSObject>

@required

- (void)imageDidFail:(int)index;
- (void)imageDidFinishLoading:(int)index;

@end

@interface Hotel : NSObject

@property (nonatomic) int code;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *region;
@property (strong, nonatomic) NSString *locality;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *web;
@property (strong, nonatomic) NSString *mail;
@property (strong, nonatomic) UIImage *smallIcon;
@property (strong, nonatomic) UIImage *largeIcon;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSMutableArray *images;
@property (nonatomic) float price;
@property (nonatomic) float price3;
@property (nonatomic) float price12;
@property (nonatomic) float minorPrice;
@property (nonatomic) float majorPrice;
@property (nonatomic) int services;
@property (nonatomic) int valorations;
@property (nonatomic) float rating;
@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;
@property (nonatomic) CLLocationDistance distance;
@property (nonatomic) int regionCode;

@property (nonatomic, getter = isIconLoading) BOOL iconLoading;
@property (nonatomic, getter = isIconLoaded) BOOL iconLoaded;
@property (strong, nonatomic) NSMutableArray *loadIconDelegates;

@property (nonatomic, getter = isImageLoading) BOOL imageLoading;
@property (nonatomic, getter = isImageLoaded) BOOL imageLoaded;
@property (strong, nonatomic) NSMutableArray *loadImageDelegates;

@property (nonatomic, getter = isImagesLoading) BOOL imagesLoading;
@property (nonatomic, getter = isImagesLoaded) BOOL imagesLoaded;
@property (strong, nonatomic) NSMutableArray *loadImagesDelegates;

- (void)downloadIcon;
- (void)downloadImage;
- (void)downloadImages;

@end

@interface Region : NSObject

@property (nonatomic) int type;
@property (nonatomic) int code;
@property (strong, nonatomic) NSString *name;
@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;
@property (strong, nonatomic) NSMutableArray *hotels;
@property (strong, nonatomic) NSMutableArray* localities;

@end

@interface Locality : NSObject

@property (nonatomic) int type;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *region;
@property (strong, nonatomic) NSMutableArray *hotels;

@end

@interface Price : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) float lower;
@property (nonatomic) float upper;
@property (strong, nonatomic) NSMutableArray *hotels;

@end

@interface Service : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) int code;
@property (strong, nonatomic) UIImage *icon;
@property (strong, nonatomic) UIImage *smallIcon;
@property (nonatomic) int count;

@end

@interface Comment : NSObject

@property (nonatomic) Hotel *hotel;
@property (nonatomic) int index;
@property (strong, nonatomic) NSString *nick;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *added;
@property (nonatomic) double rating;
@property (strong, nonatomic) NSDate *date;

@end

@interface Data : NSObject

@property (strong, nonatomic) NSMutableArray *hotels;
@property (strong, nonatomic) NSMutableArray *services;
@property (strong, nonatomic) NSMutableArray *promotions;
@property (strong, nonatomic) NSMutableArray *comments;
@property (strong, nonatomic) NSMutableArray *regions;
@property (strong, nonatomic) NSMutableArray *prices;
@property (strong, nonatomic) NSMutableArray *featuredHotels;

@property (strong, nonatomic) Region *activeRegion;
@property (strong, nonatomic) NSMutableArray *activeHotels;
@property (strong, nonatomic) NSMutableArray *activeLocalities;
@property (strong, nonatomic) NSMutableArray *activeServices;
@property (strong, nonatomic) NSMutableArray *activePrices;
@property (strong, nonatomic) NSMutableArray *activePromotions;
@property (strong, nonatomic) NSMutableArray *activeComments;

+ (Data *)instance;

@end

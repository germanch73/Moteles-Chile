//
//  UI.h
//  iMoteles
//
//  Created by Germán Chávez on 05-11-12.
//  Copyright (c) 2012 Germán Chávez. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VIEW_COLOR [UIColor colorWithRed:102.0/255.0 green:21.0/255.0 blue:158.0/255.0 alpha:1]

#define TABLE_COLOR [UIColor colorWithRed:171.0/255.0 green:0 blue:250.0/255.0 alpha:1]

#define SEPARATOR_COLOR [UIColor colorWithRed:137.0/255.0 green:0 blue:202.0/255.0 alpha:1]

#define HEADER_COLOR [UIColor colorWithRed:193.0/255.0 green:12.0/255.0 blue:222.0/255.0 alpha:1]

#define HEADER_HEIGHT 48

#define TEXT_COLOR [UIColor whiteColor]

#define DETAIL_TEXT_COLOR [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]

#define TEXT_FONT [UIFont fontWithName:@"Helvetica Neue" size:17]

#define DETAIL_TEXT_FONT [UIFont fontWithName:@"Helvetica Neue" size:17]

#define SELECTION_COLOR [UIColor colorWithRed:115.0/255.0 green:0 blue:168.0/255.0 alpha:1]

#define HOTEL_HEIGHT 69

@interface UI : NSObject

@property (strong, nonatomic) UIImage *placeholderImage;
@property (strong, nonatomic) UIImage *unknownImage;
@property (strong, nonatomic) UIImage *emptySmallIconImage;
@property (strong, nonatomic) UIImage *emptyLargeIconImage;
@property (strong, nonatomic) UIImage *emptyPictureImage;

+ (UI *)instance;

@end

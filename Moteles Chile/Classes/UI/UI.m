//
//  UI.m
//  iMoteles
//
//  Created by Germán Chávez on 05-11-12.
//  Copyright (c) 2012 Germán Chávez. All rights reserved.
//

#import "UI.h"

@interface UI ()

@end

@implementation UI

@synthesize placeholderImage = _placeholderImage;
@synthesize unknownImage = _unknownImage;
@synthesize emptySmallIconImage = _emptySmallIconImage;
@synthesize emptyLargeIconImage = _emptyLargeIconImage;
@synthesize emptyPictureImage = _emptyPictureImage;

+ (UI *)instance;
{
    static UI *ui = nil;
    
    if (!ui) {
        ui = [[UI alloc] init];
        ui.placeholderImage = [UIImage imageNamed:@"placeholder"];
        ui.unknownImage = [UIImage imageNamed:@"unknown"];
        ui.emptySmallIconImage = [UIImage ellipticImageWithImage:[UIImage imageNamed:@"empty-icon"]];
        ui.emptyLargeIconImage = [UIImage roundedImageWithImage:[UIImage imageNamed:@"empty-icon"] cornerRadius:10];
        ui.emptyPictureImage = [UIImage imageNamed:@"empty-picture"];

    }
    
    return ui;
}

@end

//
//  HotelCell.m
//  iMoteles
//
//  Created by Germán Chávez on 07-11-12.
//  Copyright (c) 2012 Germán Chávez. All rights reserved.
//

#import "HotelCell.h"
#import "HotelView.h"

@interface HotelCell () {
    HotelView *_cellContentView;
}

@end

@implementation HotelCell

@synthesize hotel = _hotel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _cellContentView = [[HotelView alloc] initWithFrame:self.bounds];
        _cellContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _cellContentView.contentMode = UIViewContentModeRedraw;
        _cellContentView.opaque = NO;
        [self.contentView addSubview:_cellContentView];
    }
    
    return self;
}

- (void)setHotel:(Hotel *)hotel
{
    _hotel = hotel;
    _cellContentView.hotel = hotel;
}

/*- (void)setIndex:(int)index
{
    _index = index;
    _cellContentView.index = index;
}*/

@end

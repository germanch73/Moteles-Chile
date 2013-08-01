//
//  HotelView.m
//  iMoteles
//
//  Created by Germán Chávez on 07-11-12.
//  Copyright (c) 2012 Germán Chávez. All rights reserved.
//

#import "HotelView.h"
#import "NSString+Format.h"

@interface HotelView () {

}

@end

@implementation HotelView

@synthesize hotel = _hotel;
@synthesize index = _index;
@synthesize highlighted = _highlighted;

- (void)drawRect:(CGRect)rect
{
    float width = self.bounds.size.width;
    
    NSString *valorations = [NSString stringWithFormat:@"(%d)", _hotel.valorations];
    
    NSString *price = [NSString stringWithPrice:_hotel.price];
    
    NSString *distance = [NSString stringWithDistance:_hotel.distance];
    
    UIFont *nameFont = [UIFont fontWithName:@"Helvetica Neue" size:17];
    
    CGSize nameSize = [_hotel.name sizeWithFont:nameFont];
    
    UIFont *addressFont = [UIFont fontWithName:@"Helvetica Neue" size:11];
    
    CGSize addressSize = [_hotel.address sizeWithFont:addressFont];
    
    UIFont *distanceFont = [UIFont fontWithName:@"Helvetica Neue" size:11];
    
    CGSize distanceSize = [distance sizeWithFont:distanceFont];
    
    UIFont *priceFont = [UIFont fontWithName:@"Helvetica Neue" size:11];
    
    CGSize priceSize = [price sizeWithFont:priceFont];
    
    UIFont *valorationsFont = [UIFont fontWithName:@"Helvetica Neue" size:11];
    
    CGSize valorationsSize = [valorations sizeWithFont:valorationsFont];
    
    CGRect iconRect = CGRectMake(6, 6, 57, 57);
    
    CGRect addressRect = CGRectMake(71, 8, width - 8 - distanceSize.width - 71 - 4, addressSize.height);
    
    CGRect distanceRect = CGRectMake(width - 8 - distanceSize.width, 8, distanceSize.width, distanceSize.height);
    
    CGRect nameRect = CGRectMake(71, 22, width - 8 - priceSize.width - 71 - 4, nameSize.height);
    
    CGRect priceRect = CGRectMake(width - 8 - priceSize.width, 28, priceSize.width, priceSize.height);
    
    CGRect valorationsRect = CGRectMake(71 + 70 + 5, 45, valorationsSize.width, valorationsSize.height);
    
    if (_hotel.smallIcon) {
        [_hotel.smallIcon drawInRect:iconRect];
    } else {
        [[[UI instance] placeholderImage] drawInRect:iconRect];
    }
    
    _highlighted ? [[UIColor whiteColor] set] : [TEXT_COLOR set];

    [_hotel.name drawInRect:nameRect withFont:nameFont lineBreakMode:NSLineBreakByTruncatingTail];
    
    _highlighted ? [[UIColor whiteColor] set] : [DETAIL_TEXT_COLOR set];
    
    [distance drawInRect:distanceRect withFont:distanceFont];
    
    [_hotel.address drawInRect:addressRect withFont:addressFont lineBreakMode:NSLineBreakByTruncatingTail];
    
    [price drawInRect:priceRect withFont:priceFont];
    
    float size = 12;
    float x = width - 8 - size + 2;
    float y = 47;
    
    NSMutableArray *services = [[Data instance] services];
    for (Service *service in services) {
        if (service.code & _hotel.services) {
            [service.smallIcon drawInRect:CGRectMake(x, y, size, size)];
            
            x -= size;
        }
    }
    
    if (_hotel.valorations) {
        [valorations drawInRect:valorationsRect withFont:valorationsFont];
        
        CGPoint ratingImageOrigin = CGPointMake(71, 45);
        UIImage *ratingBackgroundImage = [UIImage imageNamed:@"stars-background"];
        [ratingBackgroundImage drawAtPoint:ratingImageOrigin];
        UIImage *ratingForegroundImage = [UIImage imageNamed:@"stars-foreground"];
        UIRectClip(CGRectMake(ratingImageOrigin.x, ratingImageOrigin.y, ratingForegroundImage.size.width * (_hotel.rating / 5.0), ratingForegroundImage.size.height));
        [ratingForegroundImage drawAtPoint:ratingImageOrigin];
    } else {
        [@"Sin valoraciones" drawAtPoint:CGPointMake(71, 45) withFont:valorationsFont];
    }
}

- (void)setHotel:(Hotel *)hotel
{
    if (_hotel != hotel) {
        [_hotel.loadIconDelegates removeObject:self];
        _hotel = hotel;
        [_hotel.loadIconDelegates addObject:self];
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    _highlighted = highlighted;
    [self setNeedsDisplay];
}

- (BOOL)isHighlighted
{
    return _highlighted;
}

#pragma LoadIcon Delegate

- (void)iconDidFail
{
    [self setNeedsDisplay];
}

- (void)iconDidFinishLoading
{
    [self setNeedsDisplay];
}

@end

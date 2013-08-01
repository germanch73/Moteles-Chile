//
//  CommentView.m
//  Moteles Chile
//
//  Created by Germán on 26-06-12.
//  Copyright (c) 2012 Naranja Software Ltda. All rights reserved.
//

#import "CommentView.h"
#import <QuartzCore/QuartzCore.h>

@interface CommentView () 

@end

@implementation CommentView

@synthesize comment = _comment;

- (void)drawRect:(CGRect)rect
{
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString *title = [NSString stringWithFormat:@"%d. %@ (%@)", self.comment.index, self.comment.title, self.comment.hotel.name];
    NSString *by = [NSString stringWithFormat:@"de %@ - %@ (%@)", self.comment.nick, self.comment.added, [dateFormatter stringFromDate:self.comment.date]];
    
    UIFont *titleFont = [UIFont fontWithName:@"Helvetica Neue" size:14];
    UIFont *byFont = [UIFont fontWithName:@"Helvetica Neue" size:14];
    UIFont *descriptionFont = [UIFont fontWithName:@"Helvetica Neue" size:14];
    
    CGRect titleRect = CGRectMake(10, 5, width - (10 + 10), 15);
    CGRect byRect = CGRectMake(83, 5 + 15 + 2, width - (10 + 83 + 10), 15);
    CGRect commentRect = CGRectMake(10, 5 + 15 + 23, width - (10 + 10), height - (5 + 15 + 23 + 5));
    
    [[UIColor whiteColor] set];
    
    [title drawInRect:titleRect withFont:titleFont lineBreakMode:NSLineBreakByTruncatingTail];
    
    [by drawInRect:byRect withFont:byFont lineBreakMode:NSLineBreakByTruncatingTail];
    
    [self.comment.description drawInRect:commentRect withFont:descriptionFont lineBreakMode:NSLineBreakByWordWrapping];
    
    CGPoint ratingImageOrigin = CGPointMake(10, 5 + 15 + 4);
    UIImage *ratingBackgroundImage = [UIImage imageNamed:@"stars-background"];
    [ratingBackgroundImage drawAtPoint:ratingImageOrigin];
    UIImage *ratingForegroundImage = [UIImage imageNamed:@"stars-foreground"];
    UIRectClip(CGRectMake(ratingImageOrigin.x, ratingImageOrigin.y, ratingForegroundImage.size.width * (self.comment.rating / 5.0), ratingForegroundImage.size.height));
    [ratingForegroundImage drawAtPoint:ratingImageOrigin];
}

- (void)setComment:(Comment *)comment
{
    _comment = comment;
}

- (void)setFrame:(CGRect)frame
{
    CGRect oldFrame = self.frame;
    
    [super setFrame:frame];
    
    if (!CGSizeEqualToSize(oldFrame.size, frame.size)) {
        [self setNeedsDisplay];
    }
}

@end
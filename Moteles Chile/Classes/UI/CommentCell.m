//
//  CommentCell.m
//  Moteles Chile
//
//  Created by Germán on 26-06-12.
//  Copyright (c) 2012 Naranja Software Ltda. All rights reserved.
//

#import "CommentCell.h"
#import "CommentView.h"

@interface CommentCell () {
    CommentView *_cellContentView;
}

@end

@implementation CommentCell

@synthesize comment = _comment;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _cellContentView = [[CommentView alloc] initWithFrame:self.bounds];
        _cellContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _cellContentView.contentMode = UIViewContentModeScaleToFill;
        _cellContentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_cellContentView];
    }
    
    return self;
}

- (void)setComment:(Comment *)comment
{
    _comment = comment;
    _cellContentView.comment = comment;
}

/*- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _cellContentView.backgroundColor = backgroundColor;
}*/

@end
//
//  UIColor+Extensions.m
//  Moteles Chile
//
//  Created by German Chavez on 30-06-13.
//  Copyright (c) 2013 Naranja Software S.A. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

+ (UIColor *)colorWithPercentColor:(UIColor *)color percent:(float)percent
{
    float red = 0;
    float green = 0;
    float blue = 0;
    float alpha = 0;
    if ([color getRed:&red green:&green blue:&blue alpha:&alpha]) {
        red *= percent;
        green *= percent;
        blue *= percent;
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }
    return color;
}

@end

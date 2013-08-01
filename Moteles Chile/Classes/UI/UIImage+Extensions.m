//
//  UIImage+Extensions.m
//  iOnline2
//
//  Created by Germán Chávez on 14-06-13.
//  Copyright (c) 2013 Time Media Chile. All rights reserved.
//

#import "UIImage+Extensions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (Extensions)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithHeight:(float)height color:(UIColor *)color bottomColor:(UIColor *)bottomColor
{
    CGRect rect = CGRectMake(0, 0, 1, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    rect = CGRectMake(0, height - 1, 1, 1);
    CGContextSetFillColorWithColor(context, [bottomColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithPercentColor:(UIColor *)color percent:(float)percent
{
    float red = 0;
    float green = 0;
    float blue = 0;
    float alpha = 0;
    if ([color getRed:&red green:&green blue:&blue alpha:&alpha]) {
        red *= percent;
        green *= percent;
        blue *= percent;
        return [UIImage imageWithColor:[UIColor colorWithRed:red green:green blue:blue alpha:alpha]];
    }
    return [UIImage imageWithColor:color];
}

+ (UIImage *)ellipticImageWithImage:(UIImage *)image
{
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)roundedImageWithImage:(UIImage *)image cornerRadius:(float)cornerRadius
{
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    float radius = MIN(rect.size.width, rect.size.height) * (cornerRadius / 100.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
    CGContextMoveToPoint(context, minx, midy);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)explodeImageWithImage:(UIImage *)image width:(float)width height:(float)height
{
    CGRect rect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    //CGContextRef context = UIGraphicsGetCurrentContext();
    rect = CGRectMake((width - image.size.width) / 2, (height - image.size.height) / 2, image.size.width, image.size.height);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end

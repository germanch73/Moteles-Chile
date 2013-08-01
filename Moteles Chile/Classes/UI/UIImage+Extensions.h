//
//  UIImage+Color.h
//  iOnline2
//
//  Created by Germán Chávez on 14-06-13.
//  Copyright (c) 2013 Time Media Chile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Extensions)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithHeight:(float)height color:(UIColor *)color bottomColor:(UIColor *)bottomColor;
+ (UIImage *)imageWithPercentColor:(UIColor *)color percent:(float)percent;
+ (UIImage *)ellipticImageWithImage:(UIImage *)image;
+ (UIImage *)roundedImageWithImage:(UIImage *)image cornerRadius:(float)cornerRadius;
+ (UIImage *)explodeImageWithImage:(UIImage *)image width:(float)width height:(float)height;

@end

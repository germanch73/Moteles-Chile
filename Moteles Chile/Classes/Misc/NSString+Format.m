//
//  NSString+Format.m
//  Moteles Chile
//
//  Created by Germán Chávez on 22-02-12.
//  Copyright (c) 2012 Naranja Software Ltda. All rights reserved.
//

#import "NSString+Format.h"

@implementation NSString (Format)

+ (id)stringWithDistance:(double)distance
{
    if (distance < 1000) {
        return [NSString stringWithFormat:@"%0.1f m", distance];
    } 
    
    return [NSString stringWithFormat:@"%0.1f km", distance / 1000];
}

+ (id)stringWithPrice:(double)price
{
    if (price <= 0) {
        return @"Sin precio";
    }
    
    NSNumberFormatter * numberFormat = [[NSNumberFormatter alloc]init];
    [numberFormat setPositiveFormat:@"$###,##0"];
    
    NSNumber * nsNumber = [[NSNumber alloc] initWithDouble:price];
    return [numberFormat stringFromNumber:nsNumber];
}

+ (id)stringWithPhone:(NSString *)phone
{
    if (phone.length == 10) {
        NSString *countryCode = [phone substringWithRange:NSMakeRange(0, 2)]; 
        NSString *areaCode = [phone substringWithRange:NSMakeRange(2, 1)]; 
        NSString *firstPart = [phone substringWithRange:NSMakeRange(3, 3)]; 
        NSString *lastPart = [phone substringWithRange:NSMakeRange(6, 4)];
        return [NSString stringWithFormat:@"+%@ %@ %@ %@", countryCode, areaCode, firstPart, lastPart];
    }
    
    if (phone.length == 11) {
        NSString *countryCode = [phone substringWithRange:NSMakeRange(0, 2)]; 
        NSString *areaCode = [phone substringWithRange:NSMakeRange(2, 1)]; 
        NSString *firstPart = [phone substringWithRange:NSMakeRange(3, 4)]; 
        NSString *lastPart = [phone substringWithRange:NSMakeRange(7, 4)];
        return [NSString stringWithFormat:@"+%@ %@ %@ %@", countryCode, areaCode, firstPart, lastPart];
    }
    
    return phone;
}

@end

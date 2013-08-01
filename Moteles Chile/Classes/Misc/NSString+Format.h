//
//  NSString+Format.h
//  Moteles Chile
//
//  Created by Germán Chávez on 22-02-12.
//  Copyright (c) 2012 Naranja Software Ltda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Format)

+ (id)stringWithDistance:(double)distance;
+ (id)stringWithPrice:(double)price;
+ (id)stringWithPhone:(NSString *)phone;

@end

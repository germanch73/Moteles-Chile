//
//  HotelView.h
//  iMoteles
//
//  Created by Germán Chávez on 07-11-12.
//  Copyright (c) 2012 Germán Chávez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelView : UIView<LoadIconDelegate>

@property (strong, nonatomic) Hotel *hotel;
@property (nonatomic) int index;
@property (nonatomic) BOOL highlighted;

@end

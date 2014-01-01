//
//  JYJHotel.h
//  Acquire Companion
//
//  Created by Jason Ji on 1/1/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYJHotel : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) HotelClass hotelClass;
@property (nonatomic) NSInteger size;
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) BOOL active;
@property (nonatomic) NSInteger sharesRemaining;
@property (nonatomic) NSArray *currentMajorityOwners;
@property (nonatomic) NSArray *currentMinorityOwners;

-(JYJHotel *)initWithName:(NSString *)name hotelClass:(HotelClass)hotelClass size:(NSInteger)size color:(UIColor *)color active:(BOOL)active sharesRemaining:(NSInteger)sharesRemaining;

-(NSInteger)currentStockPrice;
-(NSInteger)majorityOwnerBonus;
-(NSInteger)minorityOwnerBonus;

@end

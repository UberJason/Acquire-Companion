//
//  JYJHotel.m
//  Acquire Companion
//
//  Created by Jason Ji on 1/1/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import "JYJHotel.h"

@implementation JYJHotel

-(JYJHotel *)initWithName:(NSString *)name hotelClass:(HotelClass)hotelClass size:(NSInteger)size color:(UIColor *)color active:(BOOL)active sharesRemaining:(NSInteger)sharesRemaining {
    self = [self init];
    if(self) {
        _name = name;
        _hotelClass = hotelClass;
        _size = size;
        _color = color;
        _active = active;
        _sharesRemaining = sharesRemaining;
    }
    return self;
}

-(NSArray *)stockPrices {
    return @[@(200), @(300), @(400), @(500), @(600), @(700), @(800), @(900), @(1000), @(1100), @(1200)];
}
-(NSArray *)majorityBonuses {
    return @[@(2000), @(3000), @(4000), @(5000), @(6000), @(7000), @(8000), @(9000), @(10000), @(11000), @(12000)];
}
-(NSArray *)minorityBonuses {
    return @[@(1000), @(1500), @(2000), @(2500), @(3000), @(3500), @(4000), @(4500), @(5000), @(5500), @(6000)];
}

-(NSInteger)indexForSize {
    NSInteger index = 0;
    
    if(self.size == 2)
        index = 0;
    else if(self.size == 3)
        index = 1;
    else if(self.size == 4)
        index = 2;
    else if(self.size == 5)
        index = 3;
    else if(self.size >= 6 && self.size <= 10)
        index = 4;
    else if(self.size >= 11 && self.size <= 20)
        index = 5;
    else if(self.size >= 21 && self.size <= 30)
        index = 6;
    else if(self.size >= 31 && self.size <= 40)
        index = 7;
    else
        index = 8;
    
    if(self.hotelClass == HotelClassMedium)
        index += 1;
    else if(self.hotelClass == HotelClassLarge)
        index += 2;
    
    return index;
}

-(NSInteger)currentStockPrice {
    
    NSInteger index = [self indexForSize];
    return [[self stockPrices][index] integerValue];
    
}
-(NSInteger)majorityOwnerBonus {
    NSInteger index = [self indexForSize];
    return [[self majorityBonuses][index] integerValue] / self.currentMajorityOwners.count;
}
-(NSInteger)minorityOwnerBonus {
    if(self.currentMajorityOwners.count > 1)
        return 0;

    NSInteger index = [self indexForSize];
    return [[self minorityBonuses][index] integerValue] / self.currentMinorityOwners.count;
}

@end

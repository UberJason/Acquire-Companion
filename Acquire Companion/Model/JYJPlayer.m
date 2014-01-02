//
//  JYJPlayer.m
//  Acquire Companion
//
//  Created by Jason Ji on 1/1/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import "JYJPlayer.h"

@implementation JYJPlayer

-(JYJPlayer *)initWithName:(NSString *)name {
    self = [self init];
    if(self) {
        _name = name;
    }
    return self;
}

-(NSMutableDictionary *)sharesOfStock {
    if(!_sharesOfStock) {
        _sharesOfStock = [NSMutableDictionary new];
        _sharesOfStock[TOWER] = @(0);
        _sharesOfStock[LUXOR] = @(0);
        _sharesOfStock[AMERICAN] = @(0);
        _sharesOfStock[WORLDWIDE] = @(0);
        _sharesOfStock[FESTIVAL] = @(0);
        _sharesOfStock[IMPERIAL] = @(0);
        _sharesOfStock[CONTINENTAL] = @(0);
    }
    return _sharesOfStock;
}

-(void)buyStock:(NSString *)hotelName numberOfShares:(NSInteger)shares {
    NSInteger currentShares = [self.sharesOfStock[hotelName] integerValue];
    currentShares += shares;
    
    if(currentShares < MAX_SHARES)
        self.sharesOfStock[hotelName] = @(currentShares);
}

-(void)sellStock:(NSString *)hotelName numberOfShares:(NSInteger)shares {
    NSInteger currentShares = [self.sharesOfStock[hotelName] integerValue];
    currentShares -= shares;
    
    if(currentShares >= 0)
        self.sharesOfStock[hotelName] = @(currentShares);
}

@end

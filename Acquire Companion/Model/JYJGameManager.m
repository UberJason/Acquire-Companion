//
//  JYJGameManager.m
//  Acquire Companion
//
//  Created by Jason Ji on 1/1/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import "JYJGameManager.h"

@implementation JYJGameManager

-(NSMutableArray *)players {
    if(!_players)
        _players = [NSMutableArray new];
    return _players;
}

-(NSDictionary *)hotels {
    if(!_hotels) {
        _hotels = @{
                    TOWER : [[JYJHotel alloc] initWithName:TOWER hotelClass:HotelClassSmall size:0 color:[UIColor colorWithRed:255 green:221 blue:0 alpha:1.0] active:NO sharesRemaining:MAX_SHARES],
                    LUXOR : [[JYJHotel alloc] initWithName:LUXOR hotelClass:HotelClassSmall size:0 color:[UIColor redColor] active:NO sharesRemaining:MAX_SHARES],
                    AMERICAN : [[JYJHotel alloc] initWithName:AMERICAN hotelClass:HotelClassMedium size:0 color:[UIColor blueColor] active:NO sharesRemaining:MAX_SHARES],
                    WORLDWIDE : [[JYJHotel alloc] initWithName:WORLDWIDE hotelClass:HotelClassMedium size:0 color:[UIColor brownColor] active:NO sharesRemaining:MAX_SHARES],
                    FESTIVAL : [[JYJHotel alloc] initWithName:FESTIVAL hotelClass:HotelClassMedium size:0 color:[UIColor nephritisFlatColor] active:NO sharesRemaining:MAX_SHARES],
                    IMPERIAL : [[JYJHotel alloc] initWithName:IMPERIAL hotelClass:HotelClassLarge size:0 color:[UIColor colorWithRed:231 green:0 blue:101 alpha:1.0] active:NO sharesRemaining:MAX_SHARES],
                    CONTINENTAL : [[JYJHotel alloc] initWithName:CONTINENTAL hotelClass:HotelClassLarge size:0 color:[UIColor peterRiverFlatColor] active:NO sharesRemaining:MAX_SHARES]
                    };
    }
    return _hotels;
}

-(JYJGameManager *)initWithPlayers:(NSMutableArray *)players {
    self = [self init];
    if(self) {
        _players = players;
    }
    return self;
}

+(NSArray *)hotelNames {
    return @[TOWER, LUXOR, AMERICAN, WORLDWIDE, FESTIVAL, IMPERIAL, CONTINENTAL];
}

-(void)addStock:(NSString *)hotelName toPlayer:(JYJPlayer *)player numberOfShares:(NSInteger)numberOfShares {
    JYJHotel *hotel = self.hotels[hotelName];
    if(hotel.sharesRemaining - numberOfShares >= 0) {
        [player buyStock:hotelName numberOfShares:numberOfShares];
        hotel.sharesRemaining -= numberOfShares;
    }
    
    [self calculateMajorityAndMinorityOwnersForHotel:hotel];
    
}
-(void)removeStock:(NSString *)hotelName fromPlayer:(JYJPlayer *)player numberOfShares:(NSInteger)numberOfShares {
    JYJHotel *hotel = self.hotels[hotelName];
    if(hotel.sharesRemaining + numberOfShares <= MAX_SHARES) {
        [player sellStock:hotelName numberOfShares:numberOfShares];
        hotel.sharesRemaining += numberOfShares;
    }
    [self calculateMajorityAndMinorityOwnersForHotel:hotel];
}

-(void)calculateMajorityAndMinorityOwnersForHotel:(JYJHotel *)hotel {
    NSArray *sortedPlayers = [self.players sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        JYJPlayer *player1 = (JYJPlayer *)obj1;
        JYJPlayer *player2 = (JYJPlayer *)obj2;
        
        if([player1.sharesOfStock[hotel.name] integerValue] > [player2.sharesOfStock[hotel.name] integerValue])
            return NSOrderedAscending;
        else if([player1.sharesOfStock[hotel.name] integerValue] == [player2.sharesOfStock[hotel.name] integerValue])
            return NSOrderedSame;
        else
            return NSOrderedDescending;
    }];
    
    NSMutableArray *majorityOwners = [NSMutableArray new];
    NSMutableArray *minorityOwners = [NSMutableArray new];
    NSMutableArray *currentList = majorityOwners;
    
    NSInteger maxSharesCount = [((JYJPlayer *)sortedPlayers[0]).sharesOfStock[hotel.name] integerValue];
    
    for(JYJPlayer *player in sortedPlayers) {
        if([player.sharesOfStock[hotel.name] integerValue] == maxSharesCount) {
            if([player.sharesOfStock[hotel.name] integerValue] > 0) {
                [currentList addObject:player];
            }
        }
        else {
            maxSharesCount = [player.sharesOfStock[hotel.name] integerValue];
            currentList = (currentList == majorityOwners ? minorityOwners : nil);
            if(currentList) {
                if([player.sharesOfStock[hotel.name] integerValue] > 0) {
                    [currentList addObject:player];
                }
            }
            else
                break;
        }
    }
    
    hotel.currentMajorityOwners = majorityOwners;
    if(hotel.currentMajorityOwners.count == 1)
        hotel.currentMinorityOwners = minorityOwners;
    else
        hotel.currentMinorityOwners = nil;
}

-(NSArray *)majorityOwnersForHotel:(JYJHotel *)hotel {

    [self calculateMajorityAndMinorityOwnersForHotel:hotel];
    return hotel.currentMajorityOwners;
        
}

-(NSArray *)minorityOwnersForHotel:(JYJHotel *)hotel {
    
    [self calculateMajorityAndMinorityOwnersForHotel:hotel];
    return hotel.currentMinorityOwners;
    
}

-(NSArray *)majorityOwnerNamesForHotel:(JYJHotel *)hotel {
    NSArray *majorityOwners = [self majorityOwnersForHotel:hotel];
    NSMutableArray *names = [NSMutableArray new];
    for(JYJPlayer *player in majorityOwners)
        [names addObject:player.name];
    
    return [NSArray arrayWithArray:names];
}

-(NSArray *)minorityOwnerNamesForHotel:(JYJHotel *)hotel {
    NSArray *minorityOwners = [self minorityOwnersForHotel:hotel];
    NSMutableArray *names = [NSMutableArray new];
    for(JYJPlayer *player in minorityOwners)
        [names addObject:player.name];
    
    return [NSArray arrayWithArray:names];
}

-(void)destroyHotel:(JYJHotel *)hotel {
    
    hotel.active = NO;
    hotel.size = 0;

}

-(void)createHotel:(JYJHotel *)hotel {
    
    if(!hotel.active) {
        hotel.active = YES;
        hotel.size = 2;
    }
}

@end

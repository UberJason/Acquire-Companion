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
                    TOWER : [[JYJHotel alloc] initWithName:TOWER hotelClass:HotelClassSmall size:0 color:[UIColor yellowColor] active:NO sharesRemaining:MAX_SHARES],
                    LUXOR : [[JYJHotel alloc] initWithName:LUXOR hotelClass:HotelClassSmall size:0 color:[UIColor pumpkinFlatColor] active:NO sharesRemaining:MAX_SHARES],
                    AMERICAN : [[JYJHotel alloc] initWithName:AMERICAN hotelClass:HotelClassMedium size:0 color:[UIColor blueColor] active:NO sharesRemaining:MAX_SHARES],
                    WORLDWIDE : [[JYJHotel alloc] initWithName:WORLDWIDE hotelClass:HotelClassMedium size:0 color:[UIColor brownColor] active:NO sharesRemaining:MAX_SHARES],
                    FESTIVAL : [[JYJHotel alloc] initWithName:FESTIVAL hotelClass:HotelClassMedium size:0 color:[UIColor nephritisFlatColor] active:NO sharesRemaining:MAX_SHARES],
                    IMPERIAL : [[JYJHotel alloc] initWithName:IMPERIAL hotelClass:HotelClassLarge size:0 color:[UIColor alizarinFlatColor] active:NO sharesRemaining:MAX_SHARES],
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

-(void)addStock:(NSString *)hotelName toPlayer:(JYJPlayer *)player numberOfShares:(NSInteger)numberOfShares {
    JYJHotel *hotel = self.hotels[hotelName];
    if(hotel.sharesRemaining - numberOfShares >= 0) {
        [player buyStock:hotelName numberOfShares:numberOfShares];
        hotel.sharesRemaining -= numberOfShares;
    }
    
}
-(void)removeStock:(NSString *)hotelName fromPlayer:(JYJPlayer *)player numberOfShares:(NSInteger)numberOfShares {
    JYJHotel *hotel = self.hotels[hotelName];
    if(hotel.sharesRemaining + numberOfShares <= MAX_SHARES) {
        [player buyStock:hotelName numberOfShares:numberOfShares];
        hotel.sharesRemaining += numberOfShares;
    }
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
        if([player.sharesOfStock[hotel.name] integerValue] == maxSharesCount)
            [currentList addObject:player];
        else {
            maxSharesCount = [player.sharesOfStock[hotel.name] integerValue];
            currentList = (currentList == majorityOwners ? minorityOwners : nil);
            if(currentList)
                [currentList addObject:player];
            else
                break;
        }
    }
    
    hotel.currentMajorityOwners = majorityOwners;
    hotel.currentMinorityOwners = minorityOwners;
}

-(NSArray *)majorityOwnersForHotel:(JYJHotel *)hotel {

    [self calculateMajorityAndMinorityOwnersForHotel:hotel];
    return hotel.currentMajorityOwners;
        
}
-(NSArray *)minorityOwnersForHotel:(JYJHotel *)hotel {
    
    [self calculateMajorityAndMinorityOwnersForHotel:hotel];
    return hotel.currentMinorityOwners;
    
}
-(void)destroyHotel:(JYJHotel *)hotel {
    
    hotel.active = NO;
    hotel.size = 0;

}

@end

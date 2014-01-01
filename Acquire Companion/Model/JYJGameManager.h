//
//  JYJGameManager.h
//  Acquire Companion
//
//  Created by Jason Ji on 1/1/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYJPlayer.h"
#import "JYJHotel.h"

@interface JYJGameManager : NSObject

@property (strong, nonatomic) NSMutableArray *players;
@property (strong, nonatomic) NSDictionary *hotels;

-(JYJGameManager *)initWithPlayers:(NSMutableArray *)players;

-(void)addStock:(NSString *)hotelName toPlayer:(JYJPlayer *)player numberOfShares:(NSInteger)numberOfShares;
-(void)removeStock:(NSString *)hotelName fromPlayer:(JYJPlayer *)player numberOfShares:(NSInteger)numberOfShares;
-(NSArray *)majorityOwnersForHotel:(JYJHotel *)hotel;
-(NSArray *)minorityOwnersForHotel:(JYJHotel *)hotel;
-(void)destroyHotel:(JYJHotel *)hotel;

@end

//
//  JYJPlayer.h
//  Acquire Companion
//
//  Created by Jason Ji on 1/1/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYJPlayer : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableDictionary *sharesOfStock;

-(void)addStock:(NSString *)hotelName numberOfShares:(NSInteger)shares;
-(void)removeStock:(NSString *)hotelNAme numberOfShares:(NSInteger)shares;

@end

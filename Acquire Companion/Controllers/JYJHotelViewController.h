//
//  JYJHotelViewController.h
//  Acquire Companion
//
//  Created by Jason Ji on 1/5/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageIndex.h"
#import "HotelView.h"
#import "JYJGameManager.h"

@interface JYJHotelViewController : UIViewController <PageIndex, JYJAcquireCompanionDelegate>

@property (strong, nonatomic) JYJGameManager *model;

@property (weak, nonatomic) IBOutlet HotelView *towerView;
@property (weak, nonatomic) IBOutlet HotelView *luxorView;
@property (weak, nonatomic) IBOutlet HotelView *americanView;
@property (weak, nonatomic) IBOutlet HotelView *worldwideView;
@property (weak, nonatomic) IBOutlet HotelView *festivalView;
@property (weak, nonatomic) IBOutlet HotelView *imperialView;
@property (weak, nonatomic) IBOutlet HotelView *continentalView;

@property (strong, nonatomic) IBOutletCollection(HotelView) NSArray *hotelViews;

-(void)hotelView:(HotelView *)hotelView didIncreaseSizeOfHotel:(JYJHotel *)hotel;
-(void)hotelView:(HotelView *)hotelView didDecreaseSizeOfHotel:(JYJHotel *)hotel;
-(void)hotelView:(HotelView *)hotelView didDestroyHotel:(JYJHotel *)hotel;
-(void)hotelView:(HotelView *)hotelView didCreateHotel:(JYJHotel *)hotel;

@property (nonatomic) NSInteger pageIndex;
-(NSInteger)pageIndex;
-(void)setPageIndex:(NSInteger)pageIndex;

-(void)dismissPlayerListWithList:(NSArray *)newPlayerNames;

@end

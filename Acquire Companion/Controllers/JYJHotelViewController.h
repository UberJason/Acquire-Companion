//
//  JYJHotelViewController.h
//  Acquire Companion
//
//  Created by Jason Ji on 1/5/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageIndex.h"

@interface JYJHotelViewController : UIViewController <PageIndex>

@property (nonatomic) NSInteger pageIndex;

-(NSInteger)pageIndex;
-(void)setPageIndex:(NSInteger)pageIndex;

@end

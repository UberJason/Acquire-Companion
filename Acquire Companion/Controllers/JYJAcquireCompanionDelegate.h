//
//  JYJAcquireCompanionDelegate.h
//  Acquire Companion
//
//  Created by Jason Ji on 1/10/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIButtonWithIndexPath.h"

@protocol JYJAcquireCompanionDelegate <NSObject>

@optional
-(void)dismissPlayerListWithList:(NSArray *)newPlayerNames;
-(void)dismissPickerWithValue:(NSInteger)value;
-(void)buyOrSell:(UIButtonWithIndexPath *)button;

@end

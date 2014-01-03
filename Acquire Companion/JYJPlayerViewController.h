//
//  JYJPlayerViewController.h
//  Acquire Companion
//
//  Created by Jason Ji on 1/1/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYJGameManager.h"
#import "JYJHotel.h"
#import "JYJPlayer.h"
#import "JYJStockCell.h"
#import "UIColor+LightAndDark.h"

@interface JYJPlayerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) JYJGameManager *model;
@property (strong, nonatomic) IBOutletCollection(UITableView) NSArray *tableViews;
@property (strong, nonatomic) NSMutableArray *hotelShowingDetails;

@end

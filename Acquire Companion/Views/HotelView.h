//
//  HotelView.h
//  Acquire Companion
//
//  Created by Jason Ji on 1/5/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYJHotel.h"
#import "UIColor+LightAndDark.h"
@class JYJHotelViewController;

@interface HotelView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *sharesLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLeftLabel;

@property (weak, nonatomic) IBOutlet UILabel *sizeRightLabel;
@property (weak, nonatomic) IBOutlet UILabel *sharesRightLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstRightLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondRightLabel;

@property (weak, nonatomic) IBOutlet UIButton *increaseSizeButton;
@property (weak, nonatomic) IBOutlet UIButton *decreaseSizeButton;
@property (weak, nonatomic) IBOutlet UIButton *startDestroyHotelButton;

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) JYJHotel *hotel;
@property (weak, nonatomic) JYJHotelViewController *delegate;

-(void)setFontColors;
-(void)fillProperties;

@end

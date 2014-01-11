//
//  HotelView.m
//  Acquire Companion
//
//  Created by Jason Ji on 1/5/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import "HotelView.h"
#import "JYJHotelViewController.h"

@implementation HotelView

-(void)awakeFromNib {
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.contentView];
    [self.startDestroyHotelButton setTitle:@"Start Hotel" forState:UIControlStateNormal];
    
}

-(void)setFontColors {
    self.titleLabel.textColor = [self.hotel.color darkerColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    self.sizeLeftLabel.textColor = [self.hotel.color darkerColor];
    self.sizeRightLabel.textColor = [self.hotel.color darkerColor];
    self.sharesLeftLabel.textColor = [self.hotel.color darkerColor];
    self.sharesRightLabel.textColor = [self.hotel.color darkerColor];
    self.firstLeftLabel.textColor = [self.hotel.color darkerColor];
    self.firstRightLabel.textColor = [self.hotel.color darkerColor];
    self.secondLeftLabel.textColor = [self.hotel.color darkerColor];
    self.secondRightLabel.textColor = [self.hotel.color darkerColor];
    
    [self setButtonPropertiesForButton:self.increaseSizeButton];
    [self setButtonPropertiesForButton:self.decreaseSizeButton];
    [self setButtonPropertiesForButton:self.startDestroyHotelButton];

}

-(void)fillProperties {
    self.contentView.backgroundColor = [self.hotel.color lighterColor];
    
    if(self.hotel.active)
        self.titleLabel.text = [NSString stringWithFormat:@"%@: $%ld", self.hotel.name, (long)[self.hotel currentStockPrice]];
    else
        self.titleLabel.text = [NSString stringWithFormat:@"%@: INACTIVE", self.hotel.name];
    
    self.sizeRightLabel.text = [NSString stringWithFormat:@"%ld", (long)self.hotel.size];
    self.sharesRightLabel.text = [NSString stringWithFormat:@"%ld", (long)self.hotel.sharesRemaining];
    
    self.firstRightLabel.text = [[self.delegate.model majorityOwnerNamesForHotel:self.hotel] componentsJoinedByString:@", "];
    self.secondRightLabel.text = [[self.delegate.model minorityOwnerNamesForHotel:self.hotel] componentsJoinedByString:@", "];
    
    if(!self.hotel.active) {
        self.increaseSizeButton.enabled = NO;
        self.increaseSizeButton.alpha = 0.5;
        self.decreaseSizeButton.enabled = NO;
        self.decreaseSizeButton.alpha = 0.5;
    }
    else {
        self.increaseSizeButton.enabled = YES;
        self.increaseSizeButton.alpha = 1.0;
        self.decreaseSizeButton.enabled = YES;
        self.decreaseSizeButton.alpha = 1.0;
    }
}

-(void)setButtonPropertiesForButton:(UIButton *)button {
    [button setTitleColor:[self.hotel.color darkerColor] forState:UIControlStateNormal];
    button.layer.borderColor = [[self.hotel.color darkerColor] CGColor];
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = 4.0f;
    button.backgroundColor = [UIColor whiteColor];
}
- (IBAction)increaseSize {
    [self.delegate hotelView:self didIncreaseSizeOfHotel:self.hotel];
}
- (IBAction)decreaseSize {
    [self.delegate hotelView:self didDecreaseSizeOfHotel:self.hotel];
}
- (IBAction)startOrDestroyHotel {
    
    if(self.hotel.active) {
        [self.delegate hotelView:self didDestroyHotel:self.hotel];
    [self.startDestroyHotelButton setTitle:@"Start Hotel" forState:UIControlStateNormal];
    }
    else {
        [self.delegate hotelView:self didCreateHotel:self.hotel];
    [self.startDestroyHotelButton setTitle:@"Destroy Hotel" forState:UIControlStateNormal];
    }
}


@end

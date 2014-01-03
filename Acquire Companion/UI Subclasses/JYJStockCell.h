//
//  JYJStockCell.h
//  Acquire Companion
//
//  Created by Jason Ji on 1/1/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButtonWithIndexPath.h"

@interface JYJStockCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stockNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (weak, nonatomic) IBOutlet UIButtonWithIndexPath *plus1Button;
@property (weak, nonatomic) IBOutlet UIButtonWithIndexPath *plus2Button;
@property (weak, nonatomic) IBOutlet UIButtonWithIndexPath *plus3Button;

@property (weak, nonatomic) IBOutlet UIButtonWithIndexPath *minus1Button;
@property (weak, nonatomic) IBOutlet UIButtonWithIndexPath *minus2Button;
@property (weak, nonatomic) IBOutlet UIButtonWithIndexPath *minus3Button;

@property (weak, nonatomic) IBOutlet UIView *detailsPanel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailsPanelHeight;

@property (nonatomic) BOOL showingDetails;

@end

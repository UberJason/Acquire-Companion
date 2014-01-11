//
//  JYJPlayerNameCell.h
//  Acquire Companion
//
//  Created by Jason Ji on 1/10/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextFieldWithIndexPath.h"

@interface JYJPlayerNameCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UITextFieldWithIndexPath *textField;

@end

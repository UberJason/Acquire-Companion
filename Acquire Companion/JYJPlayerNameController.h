//
//  JYJPlayerNameController.h
//  Acquire Companion
//
//  Created by Jason Ji on 1/10/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYJPlayerNameCell.h"
#import "JYJAcquireCompanionDelegate.h"
#import "JYJPickerViewController.h"

@interface JYJPlayerNameController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, JYJAcquireCompanionDelegate>

@property (nonatomic) NSInteger numberOfPlayers;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UITextField *numberOfPlayersTextField;

@property (strong, nonatomic) UITapGestureRecognizer *tap;
@property (strong, nonatomic) NSMutableDictionary *newPlayerList;
@property (strong, nonatomic) UIPopoverController *popControl;

@property (weak, nonatomic) id<JYJAcquireCompanionDelegate> delegate;

-(void)dismissPickerWithValue:(NSInteger)value;

@end

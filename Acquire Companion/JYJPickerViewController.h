//
//  JYJPickerViewController.h
//  Acquire Companion
//
//  Created by Jason Ji on 1/10/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYJAcquireCompanionDelegate.h"

@interface JYJPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) NSInteger passedInNumber;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) id<JYJAcquireCompanionDelegate> delegate;

@end

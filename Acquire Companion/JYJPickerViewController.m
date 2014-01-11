//
//  JYJPickerViewController.m
//  Acquire Companion
//
//  Created by Jason Ji on 1/10/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import "JYJPickerViewController.h"

@interface JYJPickerViewController ()

@end

@implementation JYJPickerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.pickerView selectRow:self.passedInNumber-2 inComponent:0 animated:YES];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 5;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%d", row+2];
}
- (IBAction)donePickingValues:(UIBarButtonItem *)sender {
    NSLog(@"done tapped");
    NSInteger numberToReturn = [self.pickerView selectedRowInComponent:0]+2;
    [self.delegate dismissPickerWithValue:numberToReturn];
}


@end

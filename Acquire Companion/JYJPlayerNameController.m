//
//  JYJPlayerNameController.m
//  Acquire Companion
//
//  Created by Jason Ji on 1/10/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import "JYJPlayerNameController.h"

@interface JYJPlayerNameController ()

@end

@implementation JYJPlayerNameController

-(UITapGestureRecognizer *)tap {
    if(!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPickerView)];
    }
    return _tap;
}

-(NSMutableDictionary *)newPlayerList {
    if(!_newPlayerList)
        _newPlayerList = [NSMutableDictionary new];
    return _newPlayerList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.numberOfPlayers = 2;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.numberOfPlayersTextField.text = [NSString stringWithFormat:@"%d", self.numberOfPlayers];
    [self.numberOfPlayersTextField addGestureRecognizer:self.tap];
    [self.tableView layoutIfNeeded];
    
    self.tableViewHeight.constant = self.tableView.contentSize.height;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Player Names";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberOfPlayers;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    JYJPlayerNameCell *cell = (JYJPlayerNameCell *)[tableView dequeueReusableCellWithIdentifier:identifier];

    cell.leftLabel.text = [NSString stringWithFormat:@"Player %d's Name", indexPath.row+1];
    cell.leftLabel.textColor = [UIColor emeraldFlatColor];
    
    cell.textField.placeholder = [NSString stringWithFormat:@"Player %d", indexPath.row+1];
    if(self.newPlayerList[@(indexPath.row)])
        cell.textField.text = [NSString stringWithFormat:@"%d", [self.newPlayerList[@(indexPath.row)] integerValue]];
    
    cell.textField.delegate = self;
    cell.textField.indexPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"begin editing");
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"end editing");
    if(!textField.text || [textField.text isEqualToString:@""])
        textField.text = @"";
    NSNumber *index = @(((UITextFieldWithIndexPath *)textField).indexPath.row);
    self.newPlayerList[index] = textField.text;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)saveAndPlay {
    
    NSMutableArray *newPlayerList = [NSMutableArray new];
    
    for(NSInteger index = 0; index < self.numberOfPlayers; index++) {
        if(!self.newPlayerList[@(index)]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Must enter a name for all players." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        else
            [newPlayerList addObject:self.newPlayerList[@(index)]];
    }
    
    [self.delegate dismissPlayerListWithList:newPlayerList];

}

-(void)showPickerView {
    NSLog(@"tap");
    if(self.popControl && self.popControl.popoverVisible)
        return;
    
    JYJPickerViewController *pickerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"pickerViewController"];
    pickerVC.delegate = self;
    pickerVC.passedInNumber = self.numberOfPlayers;
    NSLog(@"width: %f, height: %f", pickerVC.view.frame.size.width, pickerVC.view.frame.size.height);
    self.popControl = [[UIPopoverController alloc] initWithContentViewController:pickerVC];
    self.popControl.popoverContentSize = CGSizeMake(pickerVC.view.frame.size.width, pickerVC.view.frame.size.height);
    
    CGRect displayRect = CGRectMake(self.numberOfPlayersTextField.frame.origin.x+self.numberOfPlayersTextField.frame.size.width, self.numberOfPlayersTextField.frame.origin.y+self.numberOfPlayersTextField.frame.size.height, 1, 1);
    
    [self.popControl presentPopoverFromRect:displayRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)dismissPickerWithValue:(NSInteger)value {
    [self.popControl dismissPopoverAnimated:YES];
    self.popControl = nil;
    self.numberOfPlayers = value;
    self.numberOfPlayersTextField.text = [NSString stringWithFormat:@"%d", self.numberOfPlayers];
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    self.tableViewHeight.constant = self.tableView.contentSize.height;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}
@end

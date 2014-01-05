//
//  JYJPlayerViewController.m
//  Acquire Companion
//
//  Created by Jason Ji on 1/1/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import "JYJPlayerViewController.h"

@interface JYJPlayerViewController ()

@end

@implementation JYJPlayerViewController

-(JYJGameManager *)model {
    if(!_model) {
        JYJAppDelegate *delegate = (JYJAppDelegate *)[[UIApplication sharedApplication] delegate];
        _model = delegate.model;
    }
    
    return _model;
}

-(NSMutableArray *)hotelShowingDetails {
    if(!_hotelShowingDetails) {
        _hotelShowingDetails = [@[@(-1), @(-1), @(-1), @(-1), @(-1), @(-1), @(-1)] mutableCopy];
    }
    return _hotelShowingDetails;
}

-(NSInteger)detailsPanelHeight:(BOOL)showing {
    return (showing ? 75 : 0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    for(UITableView *tableView in self.tableViews) {
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.separatorColor = [UIColor blackColor];
        tableView.backgroundColor = [UIColor lightGrayColor];
    }
}

#pragma mark - tableview delegate/data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger indexOfPlayerTableView = [self.tableViews indexOfObject:tableView];
    if([self.hotelShowingDetails[indexOfPlayerTableView] integerValue] == indexPath.row)
        return 150;
    else
        return 50;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSInteger indexOfPlayerTableView = [self.tableViews indexOfObject:tableView];
    JYJPlayer *player = self.model.players[indexOfPlayerTableView];
    
    return player.name;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger indexOfPlayerTableView = [self.tableViews indexOfObject:tableView];
    UITableView *currentTableView = self.tableViews[indexOfPlayerTableView];
    JYJPlayer *player = self.model.players[indexOfPlayerTableView];
    JYJHotel *hotel = self.model.hotels[ [JYJGameManager hotelNames][indexPath.row] ];
    
    NSString *cellIdentifier = @"stockCell";
    
    JYJStockCell *cell = (JYJStockCell *)[currentTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.stockNameLabel.text = hotel.name;
    cell.amountLabel.text = [NSString stringWithFormat:@"%d shares", [player.sharesOfStock[hotel.name] integerValue]];
    
    if(cell.showingDetails) {
        cell.detailsPanel.alpha = 1.0;
        cell.detailsPanelHeight.constant = [self detailsPanelHeight:YES];
    }
    else {
        cell.detailsPanel.alpha = 0.0;
        cell.detailsPanelHeight.constant = [self detailsPanelHeight:NO];
    }
    
    cell.backgroundColor = [hotel.color lighterColor];
    cell.stockNameLabel.textColor = [hotel.color darkerColor];
    cell.stockNameLabel.font = [UIFont boldSystemFontOfSize:17.0];
    cell.amountLabel.textColor = [hotel.color darkerColor];
    cell.amountLabel.font = [UIFont boldSystemFontOfSize:17.0];
    
    [self setButtonPropertiesForButton:cell.plus1Button withColor:[hotel.color darkerColor] tableView:tableView indexPath:indexPath];
    [self setButtonPropertiesForButton:cell.plus2Button withColor:[hotel.color darkerColor] tableView:tableView indexPath:indexPath];
    [self setButtonPropertiesForButton:cell.plus3Button withColor:[hotel.color darkerColor] tableView:tableView indexPath:indexPath];
    [self setButtonPropertiesForButton:cell.minus1Button withColor:[hotel.color darkerColor] tableView:tableView indexPath:indexPath];
    [self setButtonPropertiesForButton:cell.minus2Button withColor:[hotel.color darkerColor] tableView:tableView indexPath:indexPath];
    [self setButtonPropertiesForButton:cell.minus3Button withColor:[hotel.color darkerColor] tableView:tableView indexPath:indexPath];

    
    [self enableOrDisableButton:cell.plus1Button forChange:1 player:player hotel:hotel];
    [self enableOrDisableButton:cell.plus2Button forChange:2 player:player hotel:hotel];
    [self enableOrDisableButton:cell.plus3Button forChange:3 player:player hotel:hotel];
    [self enableOrDisableButton:cell.minus1Button forChange:-1 player:player hotel:hotel];
    [self enableOrDisableButton:cell.minus2Button forChange:-2 player:player hotel:hotel];
    [self enableOrDisableButton:cell.minus3Button forChange:-3 player:player hotel:hotel];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger indexOfPlayerTableView = [self.tableViews indexOfObject:tableView];
    JYJPlayer *player = self.model.players[indexOfPlayerTableView];
    JYJHotel *hotel = self.model.hotels[ [JYJGameManager hotelNames][indexPath.row] ];
    JYJStockCell *cell = (JYJStockCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    [self enableOrDisableButton:cell.plus1Button forChange:1 player:player hotel:hotel];
    [self enableOrDisableButton:cell.plus2Button forChange:2 player:player hotel:hotel];
    [self enableOrDisableButton:cell.plus3Button forChange:3 player:player hotel:hotel];
    [self enableOrDisableButton:cell.minus1Button forChange:-1 player:player hotel:hotel];
    [self enableOrDisableButton:cell.minus2Button forChange:-2 player:player hotel:hotel];
    [self enableOrDisableButton:cell.minus3Button forChange:-3 player:player hotel:hotel];
    
    if([self.hotelShowingDetails[indexOfPlayerTableView] integerValue] == indexPath.row) {
        self.hotelShowingDetails[indexOfPlayerTableView] = @(-1);
        
        [tableView beginUpdates];
        [tableView endUpdates];
        
        [UIView animateWithDuration:0.3 animations:^{
            cell.detailsPanel.alpha = 0.0;
            cell.detailsPanelHeight.constant = [self detailsPanelHeight:NO];
            cell.showingDetails = NO;
            [cell.contentView layoutIfNeeded];
        }];
    }
    else {
        self.hotelShowingDetails[indexOfPlayerTableView] = @(indexPath.row);
        
        [tableView beginUpdates];
        [tableView endUpdates];
        
        [UIView animateWithDuration:0.3 animations:^{
            cell.detailsPanel.alpha = 1.0;
            cell.detailsPanelHeight.constant = [self detailsPanelHeight:YES];
            cell.showingDetails = YES;
            [cell.contentView layoutIfNeeded];
        }];
    }
    

    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)enableOrDisableButton:(UIButton *)button forChange:(NSInteger)change player:(JYJPlayer *)player hotel:(JYJHotel *)hotel {
    if([player.sharesOfStock[hotel.name] integerValue] + change < 0 || change > hotel.sharesRemaining) {
        button.enabled = NO;
        button.alpha = 0.5;
    }
    else {
        button.enabled = YES;
        button.alpha = 1.0;
    }
}

-(void)setButtonPropertiesForButton:(UIButtonWithIndexPath *)button withColor:(UIColor *)color tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    [button setTitleColor:color forState:UIControlStateNormal];
    button.layer.borderColor = [color CGColor];
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = 4.0f;
    button.backgroundColor = [UIColor whiteColor];
    button.indexOfTableView = [self.tableViews indexOfObject:tableView];
    button.indexPath = indexPath;
}

- (IBAction)buyOrSell:(UIButtonWithIndexPath *)sender {
    UITableView *tableView = self.tableViews[sender.indexOfTableView];
    JYJStockCell *cell = (JYJStockCell *)[tableView cellForRowAtIndexPath:sender.indexPath];
    JYJPlayer *player = self.model.players[sender.indexOfTableView];
    JYJHotel *hotel = self.model.hotels[ [JYJGameManager hotelNames][sender.indexPath.row] ];
    
    if(sender == cell.plus1Button) {
        NSLog(@"+1");
        [self.model addStock:hotel.name toPlayer:player numberOfShares:1];
    }
    else if(sender == cell.plus2Button) {
        NSLog(@"+2");
        [self.model addStock:hotel.name toPlayer:player numberOfShares:2];
    }
    else if(sender == cell.plus3Button) {
        NSLog(@"+3");
        [self.model addStock:hotel.name toPlayer:player numberOfShares:3];
    }
    else if(sender == cell.minus1Button) {
        NSLog(@"-1");
        [self.model removeStock:hotel.name fromPlayer:player numberOfShares:1];
    }
    else if(sender == cell.minus2Button) {
        NSLog(@"-2");
        [self.model removeStock:hotel.name fromPlayer:player numberOfShares:2];
    }
    else {
        NSLog(@"-3");
        [self.model removeStock:hotel.name fromPlayer:player numberOfShares:3];
    }

    NSLog(@"Current majority owners: ");
    for(JYJPlayer *player in hotel.currentMajorityOwners)
        NSLog(@"%@", player.name);
    
    NSLog(@"Current minority owners: ");
    for(JYJPlayer *player in hotel.currentMinorityOwners)
        NSLog(@"%@", player.name);
    
    for(UITableView *table in self.tableViews)
        [table reloadData];
}




@end
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
    if(!_model)
        _model = [[JYJGameManager alloc] initWithPlayers:[@[
                                                            [[JYJPlayer alloc] initWithName:@"Jason"],
                                                            [[JYJPlayer alloc] initWithName:@"Mary Anne"],
                                                            [[JYJPlayer alloc] initWithName:@"Dad"],
                                                            [[JYJPlayer alloc] initWithName:@"John"]
                                                            ] mutableCopy]];
    return _model;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    for(UITableView *tableView in self.tableViews) {
        tableView.delegate = self;
        tableView.dataSource = self;
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
    return 150;
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
    
    return cell;
}

@end
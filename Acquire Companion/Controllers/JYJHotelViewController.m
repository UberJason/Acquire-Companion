//
//  JYJHotelViewController.m
//  Acquire Companion
//
//  Created by Jason Ji on 1/5/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import "JYJHotelViewController.h"

@interface JYJHotelViewController ()

@end

@implementation JYJHotelViewController

-(JYJGameManager *)model {
    if(!_model) {
        JYJAppDelegate *delegate = (JYJAppDelegate *)[[UIApplication sharedApplication] delegate];
        _model = delegate.model;
    }
    
    return _model;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 	// Do any additional setup after loading the view.

    JYJPlayerNameController *playerPopover = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"playerPopover"];
    playerPopover.modalPresentationStyle = UIModalPresentationFormSheet;
    playerPopover.delegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:playerPopover animated:YES completion:nil];
    });

    self.view.backgroundColor = [UIColor lightGrayColor];
    for(int i = 0; i < [JYJGameManager hotelNames].count; i++) {
        HotelView *view = self.hotelViews[i];
        view.hotel = self.model.hotels[ [JYJGameManager hotelNames][i] ];
        view.delegate = self;
        [view setFontColors];
        [view fillProperties];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for(HotelView *view in self.hotelViews)
        [view fillProperties];
}

-(void)hotelView:(HotelView *)hotelView didIncreaseSizeOfHotel:(JYJHotel *)hotel {
    hotel.size++;
    [hotelView fillProperties];
}
-(void)hotelView:(HotelView *)hotelView didDecreaseSizeOfHotel:(JYJHotel *)hotel {
    hotel.size--;
    [hotelView fillProperties];
}
-(void)hotelView:(HotelView *)hotelView didDestroyHotel:(JYJHotel *)hotel {
    [self.model destroyHotel:hotel];
    [hotelView fillProperties];
}
-(void)hotelView:(HotelView *)hotelView didCreateHotel:(JYJHotel *)hotel {
    [self.model createHotel:hotel];
    [hotelView fillProperties];
}

-(void)dismissPlayerListWithList:(NSArray *)newPlayerNames {
    [self dismissViewControllerAnimated:YES completion:nil];
    NSMutableArray *newPlayers = [NSMutableArray new];
    for(NSString *name in newPlayerNames) {
        [newPlayers addObject:[[JYJPlayer alloc] initWithName:name]];
    }
    self.model.players = newPlayers;
}

@end

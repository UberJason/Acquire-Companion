//
//  JYJPageManagerController.h
//  Acquire Companion
//
//  Created by Jason Ji on 1/5/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageIndex.h"
#import "JYJPlayerViewController.h"

@interface JYJPageManagerController : UIPageViewController<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (strong, nonatomic) JYJGameManager *model;

@property (strong, nonatomic) NSArray *viewControllerIdentifiers;
@property (strong, nonatomic) NSMutableArray *myViewControllers;

@end

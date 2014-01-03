//
//  UIButtonWithIndexPath.h
//  Acquire Companion
//
//  Created by Jason Ji on 1/1/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButtonWithIndexPath : UIButton

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (nonatomic) NSInteger indexOfTableView;

@end

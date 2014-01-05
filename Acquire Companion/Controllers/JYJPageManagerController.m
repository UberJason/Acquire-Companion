//
//  JYJPageManagerController.m
//  Acquire Companion
//
//  Created by Jason Ji on 1/5/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import "JYJPageManagerController.h"

@interface JYJPageManagerController ()

@end

@implementation JYJPageManagerController

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

-(NSArray *)viewControllerIdentifiers {
    if(!_viewControllerIdentifiers)
        _viewControllerIdentifiers = @[@"hotelViewController", @"playerViewController"];
    return _viewControllerIdentifiers;
}

-(NSMutableArray *)myViewControllers {
    if(!_myViewControllers) {
        _myViewControllers = [NSMutableArray new];
    }
    return _myViewControllers;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.delegate = self;
    self.dataSource = self;
    for(UIGestureRecognizer *recognizer in self.gestureRecognizers) {
        recognizer.delaysTouchesBegan = NO;
        recognizer.delaysTouchesEnded = NO;
    }
    
    UIViewController<PageIndex> *controller = [self viewControllerAtIndex:0];
    
    [self setViewControllers:@[controller] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [((id<PageIndex>)viewController) pageIndex];
    
    if((index == 0) || (index == NSNotFound))
        return nil;
    
    return [self viewControllerAtIndex:index-1];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [((id<PageIndex>)viewController) pageIndex];
    
    if(index == NSNotFound)
        return nil;
    
    index++;
    
    if(index == self.viewControllerIdentifiers.count)
        return nil;
    
    return [self viewControllerAtIndex:index];
}

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.viewControllerIdentifiers.count;
}
-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

-(UIViewController<PageIndex> *)viewControllerAtIndex:(NSInteger) index {
    if((self.viewControllerIdentifiers.count == 0) || index >= self.viewControllerIdentifiers.count)
        return nil;
    
    if(self.myViewControllers.count > index && self.myViewControllers[index])
        return self.myViewControllers[index];
    else {
        UIViewController<PageIndex> *controller = [self.storyboard instantiateViewControllerWithIdentifier:self.viewControllerIdentifiers[index]];
        [controller setPageIndex:index];
        [self.myViewControllers addObject:controller];
        
        return controller;
    }
    
}

@end

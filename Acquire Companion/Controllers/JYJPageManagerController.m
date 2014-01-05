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

-(NSArray *)viewControllerIdentifiers {
    if(!_viewControllerIdentifiers)
        _viewControllerIdentifiers = @[@"playerViewController", @"hotelViewController"];
    return _viewControllerIdentifiers;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.delegate = self;
    self.dataSource = self;
    
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
    
    UIViewController<PageIndex> *controller = [self.storyboard instantiateViewControllerWithIdentifier:self.viewControllerIdentifiers[index]];
    [controller setPageIndex:index];
    
    return controller;
}

@end

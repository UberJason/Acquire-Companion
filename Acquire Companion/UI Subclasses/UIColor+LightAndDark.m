//
//  UIColor+LightAndDark.m
//  Acquire Companion
//
//  Created by Jason Ji on 1/2/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import "UIColor+LightAndDark.h"

@implementation UIColor (LightAndDark)

- (UIColor *)lighterColor
{
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s*1.3
                          brightness:MIN(b * 1.5, 1.0)
                               alpha:a*.5];
    return nil;
}

- (UIColor *)darkerColor
{
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b * 0.6
                               alpha:a];
    return nil;
}
@end

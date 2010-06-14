//
//  UINavigationController+Root.m
//  Trends
//
//  Created by Marcus Crafter on 2/05/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import "UINavigationController+Root.h"


@implementation UINavigationController (RootViewController)

- (UIViewController *)rootViewController {
    return [[self viewControllers] firstObject];
}

@end

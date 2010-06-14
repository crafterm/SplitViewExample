//
//  UISplitViewController+LeftRight.m
//  Trends
//
//  Created by Marcus Crafter on 2/05/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import "UISplitViewController+LeftRight.h"


@implementation UISplitViewController (LeftRight)

- (id)leftSideViewController {
    return [self.viewControllers firstObject];
}

- (id)rightSideViewController {
    return [self.viewControllers lastObject];
}

@end

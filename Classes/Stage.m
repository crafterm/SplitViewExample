//
//  Stage.m
//  Giro
//
//  Created by Marcus Crafter on 31/05/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import "Stage.h"


@implementation Stage

@dynamic name, image, index, link, distance;

- (NSString *)formattedName {
    return [NSString stringWithFormat:@"%@: %@", self.index, self.name];
}

- (NSString *)formattedDistance {
    return [NSString stringWithFormat:@"Stage %@ %@ kms", self.index, self.distance];
}

- (NSURL *)linkURL {
    return [NSURL URLWithString:self.link];
}

- (NSURL *)imageURL {
    return [NSURL URLWithString:self.image];
}

@end

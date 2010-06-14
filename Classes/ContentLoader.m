//
//  ContentLoader.m
//  Giro
//
//  Created by Marcus Crafter on 15/05/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import "ContentLoader.h"
#import "ContentController.h"

@implementation ContentLoader

@synthesize contentController;

- (id)initWithContentController:(ContentController *)aContentController {
    if (self = [super init]) {
        self.contentController = aContentController;
    }
    return self;
}

- (void)loadStages {
    NSBundle * bundle = [NSBundle mainBundle];
    NSString * path = [bundle pathForResource:@"stages" ofType:@"plist"];

    NSArray * stages = [NSArray arrayWithContentsOfFile:path];

    for (NSDictionary * stage in stages) {
        NSNumber * index    = [stage valueForKey:@"index"];
        NSString * name     = [stage valueForKey:@"name"];
        NSString * image    = [stage valueForKey:@"image"];
        NSString * link     = [stage valueForKey:@"link"];
        NSNumber * distance = [stage valueForKey:@"distance"];

        [self.contentController addStageWithIndex:index
                                             name:name
                                            image:image
                                             link:link
                                         distance:distance];
    }
}

- (void)dealloc {
    self.contentController = nil;
    [super dealloc];
}

@end

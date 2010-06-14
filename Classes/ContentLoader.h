//
//  ContentLoader.h
//  Giro
//
//  Created by Marcus Crafter on 15/05/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ContentController;

@interface ContentLoader : NSObject {
    ContentController * contentController;
}

@property (nonatomic, retain) ContentController * contentController;

- (id)initWithContentController:(ContentController *)aContentController;
- (void)loadStages;

@end

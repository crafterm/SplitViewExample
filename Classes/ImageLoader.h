//
//  ImageLoader.h
//  Giro
//
//  Created by Marcus Crafter on 20/05/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageLoaderDelegate;

@interface ImageLoader : NSObject {
    NSURL                 * url;
    id<ImageLoaderDelegate> delegate;
    ASIHTTPRequest        * downloader;
}

@property (nonatomic, retain, readonly) NSURL          * url;
@property (nonatomic, assign) id<ImageLoaderDelegate>    delegate;
@property (nonatomic, retain, readonly) ASIHTTPRequest * downloader;

- (id)initWithURL:(NSURL *)aUrl;
- (void)start;

@end

@protocol ImageLoaderDelegate

- (void)imageLoaderDidFinish:(UIImage *)image;
- (void)imageLoaderDidFail:(NSError *)error withLoader:(ImageLoader *)loader;

@end


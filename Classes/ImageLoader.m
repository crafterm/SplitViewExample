//
//  ImageLoader.m
//  Giro
//
//  Created by Marcus Crafter on 20/05/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import "ImageLoader.h"

@interface ImageLoader ()
@property (nonatomic, retain, readwrite) NSURL * url;
@property (nonatomic, retain, readwrite) ASIHTTPRequest * downloader;

- (void)imageLoaderDidFinish:(ASIHTTPRequest *)request;
- (void)imageLoaderDidFail:(ASIHTTPRequest *)request;

@end

@implementation ImageLoader

@synthesize url, delegate, downloader;

- (id)initWithURL:(NSURL *)aUrl {
    if (self = [super init]) {
        self.url = aUrl;
    }
    return self;
}

- (void)start {
    self.downloader = [ASIHTTPRequest requestWithURL:self.url];
    [self.downloader setDelegate:self];
    [self.downloader setDidFinishSelector:@selector(imageLoaderDidFinish:)];
    [self.downloader setDidFailSelector:@selector(imageLoaderDidFail:)];
    [self.downloader startAsynchronous];
}

- (void)imageLoaderDidFinish:(ASIHTTPRequest *)request {
    UIImage * image = [UIImage imageWithData:[request responseData]];
    [self.delegate imageLoaderDidFinish:image];
}

- (void)imageLoaderDidFail:(ASIHTTPRequest *)request {
    [self.delegate imageLoaderDidFail:[request error] withLoader:self];
}

- (void)dealloc {
    self.url        = nil;
    self.delegate   = nil;
    self.downloader = nil;
    [super dealloc];
}

@end
